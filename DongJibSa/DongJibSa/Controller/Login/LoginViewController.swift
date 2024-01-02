//
//  LoginViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/24.
//

import UIKit
import AuthenticationServices

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
        
        loginView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
        loginView.phoneLoginButton.addTarget(self, action: #selector(phoneLoginButtonTapped), for: .touchUpInside)
    }
    
    @objc func skipButtonTapped(_ sender: UIButton) {
        let viewController = LocationSettingViewController(selectLocation: [])
        self.navigationController?.navigationBar.tintColor = .bodyColor
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationController?.pushViewController(viewController, animated: true)
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
            // MEMO: 화면 전환
            
        default:
            break
        }
    }
    
    // 로그인 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
