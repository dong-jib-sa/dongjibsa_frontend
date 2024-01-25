//
//  TermsOfServiceViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/29.
//

import UIKit

class TermsOfServiceViewController: UIViewController {
    
    private let termsOfServiceView = TermsOfServiceView()
    
    var loginId: String = ""
    var email: String = ""
    var loginType: LoginType = .apple
    
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
    
    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func agreementButtonTapped(_ sender: UIButton) {
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
    
    @objc func startButtonTapped(_ sender: UIButton) {
        // MEMO: 동네설정 블라인드 처리
//        let viewController = LocationSettingViewController(selectLocation: [])
//        self.navigationController?.navigationBar.tintColor = .bodyColor
//        self.navigationItem.backButtonDisplayMode = .minimal
//        self.navigationController?.pushViewController(viewController, animated: true)
        let nickName = NickNameRandom().getRandomNickName()
        
        if loginType == .apple || loginType == .kakao {
            Network.shared.postRegisterOAuthUserLogin(type: loginType, email: email, id: loginId, nickName: nickName) { result in
                // 로그아웃 및 회원탈퇴를 위해 저장
                UserDefaults.standard.set(self.loginType.title, forKey: "LoginType")
                // 유저 식별자와 닉네임 저장
                let userId = result
                UserDefaults.standard.set(userId, forKey: "UserId")
                UserDefaults.standard.set(nickName, forKey: "UserNickName")
                
                DispatchQueue.main.async {
                    let main = UIStoryboard.init(name: "Main", bundle: nil)
                    let viewController = main.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: false)
                }
            }
        } else {
            Network.shared.postRegisterPhoneNumber(number: "01045674567", nickName: nickName) { result in
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
