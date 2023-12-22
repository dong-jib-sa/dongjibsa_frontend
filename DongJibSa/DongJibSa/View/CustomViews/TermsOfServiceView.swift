//
//  TermsOfServiceView.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/29.
//

import UIKit

class TermsOfServiceView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 이용약관에 동의해주세요."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    let agreementButton: UIButton = {
        var attString = AttributedString("약관 전체동의")
        attString.font = .systemFont(ofSize: 16, weight: .bold)
        attString.foregroundColor = .bodyColor
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: 13, bottom: .zero, trailing: 13)
        configuration.imagePadding = 10
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
//            button.setPreferredSymbolConfiguration(.init(pointSize: 20), forImageIn: .normal)
        button.tintColor = .systemGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 8
        button.contentHorizontalAlignment = .leading
        button.isSelected = false
        return button
    }()
    
    let checkButton: UIButton = {
        var attString = AttributedString("[필수] 서비스 이용약관")
        attString.font = .systemFont(ofSize: 16)
        attString.foregroundColor = .bodyColor
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "square"), for: .normal) // checkmark.square.fill
        button.tintColor = .systemGray
        button.contentHorizontalAlignment = .leading
        button.isSelected = false
        return button
    }()
    
    let discriptionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.tintColor = .systemGray
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkButton, discriptionButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let checkButton2: UIButton = {
        var attString = AttributedString("[필수] 개인정보 수집 및 이용동의")
        attString.font = .systemFont(ofSize: 16)
        attString.foregroundColor = .bodyColor
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "square"), for: .normal) // checkmark.square.fill
        button.tintColor = .systemGray
        button.contentHorizontalAlignment = .leading
        button.isSelected = false
        return button
    }()
    
    let discriptionButton2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.tintColor = .systemGray
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    
    lazy var stackView2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkButton2, discriptionButton2])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let checkButton3: UIButton = {
        var attString = AttributedString("[필수] 만 14세 이상입니다.")
        attString.font = .systemFont(ofSize: 16)
        attString.foregroundColor = .bodyColor
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
        configuration.imagePadding = 8
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "square"), for: .normal) // checkmark.square.fill
        button.tintColor = .systemGray
        button.contentHorizontalAlignment = .leading
        button.isSelected = false
        return button
    }()
    
    let discriptionButton3: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.tintColor = .systemGray
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    
    lazy var stackView3: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkButton3, discriptionButton3])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, stackView2, stackView3])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = .accentColor
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    var isSelected: Bool {
        didSet {
            if isSelected {
                self.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                self.checkButton2.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                self.checkButton3.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                self.checkButton.tintColor = .primaryColor
                self.checkButton2.tintColor = .primaryColor
                self.checkButton3.tintColor = .primaryColor
            } else {
                self.checkButton.setImage(UIImage(systemName: "square"), for: .normal)
                self.checkButton2.setImage(UIImage(systemName: "square"), for: .normal)
                self.checkButton3.setImage(UIImage(systemName: "square"), for: .normal)
                self.checkButton.tintColor = .systemGray
                self.checkButton2.tintColor = .systemGray
                self.checkButton3.tintColor = .systemGray
            }
        }
    }
    
    override init(frame: CGRect) {
        self.isSelected = false
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        stackView.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        stackView2.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        stackView3.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        addSubview(titleLabel)
        addSubview(agreementButton)
        addSubview(mainStackView)
        addSubview(startButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(18)
            make.centerX.equalToSuperview()
        }
        
        agreementButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(44)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(agreementButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(104)
        }
        
        startButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.height.equalTo(54)
        }
    }
}
