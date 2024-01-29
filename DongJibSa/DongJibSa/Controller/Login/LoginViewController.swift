//
//  LoginViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/24.
//

import UIKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()

//        setNavigationBar()
        setupView()
    }
    
    private func setNavigationBar() {
        var attString = AttributedString("둘러보기")
        attString.font = .systemFont(ofSize: 12, weight: .regular)
        attString.foregroundColor = .systemGray
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 6
        
        let skipButton = UIButton(configuration: configuration)
        skipButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        skipButton.setPreferredSymbolConfiguration(.init(pointSize: 12), forImageIn: .normal)
        skipButton.tintColor = .systemGray
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        
        let skipItem = UIBarButtonItem(customView: skipButton)
        self.navigationItem.rightBarButtonItem = skipItem
    }
    
    private func setupView() {
        self.view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loginView.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
        loginView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
        loginView.phoneLoginButton.addTarget(self, action: #selector(phoneLoginButtonTapped), for: .touchUpInside)
    }
    
    @objc func skipButtonTapped(_ sender: UIButton) {
        let viewController = LocationSettingViewController(selectLocation: [])
        self.navigationController?.navigationBar.tintColor = .bodyColor
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func kakaoLoginButtonTapped(_ sender: UIButton) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            self.loginWithKakaoApp()
        } else {
            self.loginWithKakaoWeb()
        }
    }
    
    @objc func appleLoginButtonTapped(_ sender: UIButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc func phoneLoginButtonTapped(_ sender: UIButton) {
        let viewController = PhoneCertifyViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: KAKAKO SNS Login
extension LoginViewController {
    func loginWithKakaoApp() {
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success.")

                //do something
                _ = oauthToken
                self.userInfo()
            }
        }
    }

    func loginWithKakaoWeb() {
        UserApi.shared.loginWithKakaoAccount(prompts: [.Login]) { (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success")

                // do something
                _ = oauthToken
                self.userInfo()
            }
        }
    }

    private func userInfo() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let kakaoId = user?.id {
                    guard let user = user,
                          let kakaoAccount = user.kakaoAccount,
                          let email = kakaoAccount.email
                    else { return }
                    // email, kakaoId, 로그인 타입을 서버로 전달
                    // 서버에서 유저 조회 후 있으면 홈화면으로, 없으면 약관 동의 화면으로 화면전환
                    Network.shared.postVerifyOAuthUser(type: .kakao, email: email, id: "\(kakaoId)") { result in
                        if result == "신규 Kakao 로그인 유저입니다." {
                            DispatchQueue.main.async {
                                let viewController = TermsOfServiceViewController()
                                viewController.email = email
                                viewController.loginId = "\(kakaoId)"
                                viewController.loginType = .kakao
                                self.navigationController?.pushViewController(viewController, animated: true)
                            }
                        } else if result == "기존 Kakao 로그인 유저입니다." {
                            DispatchQueue.main.async {
                                let main = UIStoryboard.init(name: "Main", bundle: nil)
                                let viewController = main.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
                                viewController.modalPresentationStyle = .fullScreen
                                self.present(viewController, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: Apple Login
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // 로그인을 진행하는 화면
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
        
    // 로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let idToken = appleIDCredential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("token : \(String(describing: tokeStr))")
            
            UserDefaults.standard.setValue(userIdentifier, forKey: "AppleUserId")
            Network.shared.postVerifyOAuthUser(type: .apple, email: email ?? "", id: "") { result in
                
                if result == "신규 Apple 로그인 유저입니다." {
                    DispatchQueue.main.async {
                        let viewController = TermsOfServiceViewController()
                        viewController.email = email ?? ""
                        viewController.loginType = .apple
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                } else if result == "기존 Apple 로그인 유저입니다." {
                    DispatchQueue.main.async {
                        let main = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewController = main.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController, animated: false)
                    }
                }
            }
            
        default:
            break
        }
    }
    
    // 로그인 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
