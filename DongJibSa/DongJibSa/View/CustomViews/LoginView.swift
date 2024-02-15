//
//  LoginView.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/28.
//

import UIKit

class LoginView: UIView {
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LoginImage")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 Our Basket과\n지속가능한 한끼를 시작하세요!"
        label.numberOfLines = 2
        label.setTextWithLineHeight(text: label.text, lineHeight: 24)
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var mainImageAndTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainImageView, titleLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    let kakaoLoginButton: UIButton = {
        var attString = AttributedString("카카오로 3초만에 시작하기")
        attString.font = .boldSystemFont(ofSize: 16)
        attString.foregroundColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: 28, bottom: .zero, trailing: 28)
        configuration.imagePadding = 40
        configuration.image = UIImage(named: "icon_kakao")
        configuration.baseForegroundColor = .black
        
        let button = UIButton(configuration: configuration)
        button.backgroundColor = UIColor(hex: 0xFEE500)
        button.layer.cornerRadius = 24
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    let appleLoginButton: UIButton = {
        var attString = AttributedString("Apple로 계속하기")
        attString.font = .boldSystemFont(ofSize: 16)
        attString.foregroundColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: 28, bottom: .zero, trailing: 28)
        configuration.imagePadding = 60
        configuration.image = UIImage(named: "icon_apple")
        configuration.baseForegroundColor = .black
        
        let button = UIButton(configuration: configuration)
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    let phoneLoginButton: UIButton = {
        var attString = AttributedString("휴대폰 번호 로그인")
        attString.font = .boldSystemFont(ofSize: 16)
        attString.foregroundColor = .white
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.baseForegroundColor = .white
        
        let button = UIButton(configuration: configuration)
        button.backgroundColor = .primaryColor
        button.layer.cornerRadius = 24
        return button
    }()
    
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kakaoLoginButton, appleLoginButton, phoneLoginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    let loginButtonSetView: UIView = {
        let view = UIView()
        return view
    }()
    
    let signdButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    let seperatedView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let feedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("문의하기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    lazy var signedAndFeedbackStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signdButton, seperatedView, feedbackButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    let singedAndFeedbackView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainImageAndTitleStackView, loginButtonSetView, singedAndFeedbackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        
        loginButtonSetView.addSubview(loginStackView)
        loginStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(164)
        }
        
        seperatedView.snp.makeConstraints { make in
            make.width.equalTo(0.5)
            make.height.equalTo(12)
        }
        
        // MEMO: 블라인드 처리
//        singedAndFeedbackView.addSubview(signedAndFeedbackStackView)
//        singedAndFeedbackView.snp.makeConstraints { make in
//            make.height.equalTo(27)
//        }
//        
//        signedAndFeedbackStackView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
//        
//        singedAndFeedbackView.setContentHuggingPriority(.init(252), for: .vertical)
        
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview().inset(30)
        }
    }
}
