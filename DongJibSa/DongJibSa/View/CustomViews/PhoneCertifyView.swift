//
//  PhoneCertifyView.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/28.
//

import UIKit

class PhoneCertifyView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호를 인증해주세요."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    let discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Our Basket은 휴대폰 번호로 가입해요. 번호는\n안전하게 보관되며 서비스에 공개되지 않아요.\n "
        label.setTextWithLineHeight(text: label.text, lineHeight: 24)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "휴대폰 번호를 입력해주세요."
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.addPadding(width: 16)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let phoneButton: UIButton = {
        let button = CustomButton()
        button.setTitle("인증문자 받기", for: .normal)
        button.backgroundColor = .accentColor
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    let timerButton: UIButton = {
        let button = UIButton()
        button.setTitle("03:00", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.isHidden = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    let blockCertifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("일일 인증번호 요청 횟수를 초과했어요.", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.isHidden = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    /* 블라인드 처리
    let feedbackLabel: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호를 변경하셨나요?"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    let feedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("문의하러 가기", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setUnderline()
        return button
    }()
    
    lazy var feedbackStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [feedbackLabel, feedbackButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    */
     
    let spaceView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var discriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, discriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 21
        return stackView
    }()
    
    lazy var phoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phoneTextField, phoneButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    let certificationNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "인증번호를 입력해주세요."
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.addPadding(width: 16)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let helpMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호가 오지 않았나요?\n입력하신 정보가 정확한지 확인해주세요."
        label.numberOfLines = 2
        label.setLineSpacing(spacing: 4)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    let certificationButton: UIButton = {
        let button = CustomButton()
        button.setTitle("인증번호 확인", for: .normal)
        button.backgroundColor = .accentColor
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.isEnabled = false
        return button
    }()
    
    lazy var certificationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [certificationNumberTextField, helpMessageLabel, certificationButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.isHidden = true
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [discriptionStackView, phoneStackView, certificationStackView, spaceView])
        stackView.axis = .vertical
        stackView.distribution = .fill
//            stackView.alignment = .center
        stackView.spacing = 16
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
        
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
        
        phoneButton.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
        
        // MEMO: 블라인드 처리
//        spaceView.addSubview(feedbackStackView)
//        feedbackStackView.snp.makeConstraints { make in
//            make.height.equalTo(24)
//            make.centerX.equalToSuperview()
//        }
        
        certificationNumberTextField.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
        
        certificationButton.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
        
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(18)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        phoneButton.addSubview(timerButton)
        timerButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        phoneButton.addSubview(blockCertifyButton)
        blockCertifyButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
