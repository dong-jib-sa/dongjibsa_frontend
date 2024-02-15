//
//  TermsOfServiceViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/29.
//

import UIKit

final class TermsOfServiceViewController: UIViewController {
    
    private let termsOfServiceView = TermsOfServiceView()
    
    private var loginType: LoginType
    private var loginId: String?
    private var email: String?
    private var phoneNumber: String?
    private let nickName: String = NickNameRandom().getRandomNickName()
    
    init(loginType: LoginType, loginId: String? = nil, email: String? = nil, phoneNumber: String? = nil) {
        self.loginType = loginType
        self.loginId = loginId
        self.email = email
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setupView()
    }
    
    private func setNavigationBar() {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 23))
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setPreferredSymbolConfiguration(.init(pointSize: 23), forImageIn: .normal)
        backButton.tintColor = .bodyColor
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(termsOfServiceView)
        termsOfServiceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        termsOfServiceView.agreementButton.addTarget(self, action: #selector(agreementButtonTapped), for: .touchUpInside)
        termsOfServiceView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 약관 동의 버튼 Action
    @objc private func agreementButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.tintColor = .primaryColor
            termsOfServiceView.isSelected.toggle()
            termsOfServiceView.startButton.backgroundColor = .primaryColor
            termsOfServiceView.startButton.setTitleColor(.white, for: .normal)
            termsOfServiceView.startButton.isEnabled.toggle()
        } else {
            sender.tintColor = .systemGray
            termsOfServiceView.isSelected.toggle()
            termsOfServiceView.startButton.backgroundColor = .accentColor
            termsOfServiceView.startButton.setTitleColor(.systemGray, for: .normal)
            termsOfServiceView.startButton.isEnabled.toggle()
        }
    }
    
    @objc private func startButtonTapped(_ sender: UIButton) {
        switch self.loginType {
        case .kakao:
            registerOAuthUserLogin()
        case .apple:
            registerOAuthUserLogin()
        case .phoneNumber:
            registerPhoneNumberUserLogin()
        }
    }
    
    // 소셜 로그인으로 회원가입 서버 연동
    private func registerOAuthUserLogin() {
        guard let email = email, let loginId = loginId else { return }
        Network.shared.postRegisterOAuthUserLogin(type: loginType, email: email, id: loginId, nickName: nickName) { result in
            // 유저 정보를 앱에 저장하여 서버 통신 및 로그인을 위해 사용
            let loginInfo: [String: Any] = ["loginType": self.loginType.title, "userId": result, "nickName": self.nickName, "loginState": true]
            UserDefaults.standard.set(loginInfo, forKey: "\(self.loginType.title)LoginInfo")
            UserDefaults.standard.set(loginInfo, forKey: "User")
            
            self.presentViewController()
        }
    }
    
    // 핸드폰 번호로 회원가입 서버 연동
    private func registerPhoneNumberUserLogin() {
        guard let phoneNumber = phoneNumber else { return }
        Network.shared.postRegisterPhoneNumber(number: phoneNumber, nickName: nickName) { result in
            let loginInfo: [String: Any] = ["loginType": self.loginType.title, "userId": result, "nickName": self.nickName, "loginState": true]
            UserDefaults.standard.set(loginInfo, forKey: "phoneNumberLoginInfo")
            UserDefaults.standard.set(loginInfo, forKey: "User")
            
            self.presentViewController()
        }
    }
    
    // 회원가입 완료 시 메인 화면으로 화면 전환
    private func presentViewController() {
        DispatchQueue.main.async {
            let main = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = main.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: false)
        }
    }
}
