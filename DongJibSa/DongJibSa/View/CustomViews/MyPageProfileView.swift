//
//  MyPageProfileView.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/02.
//

import UIKit

class MyPageProfileView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .primaryColor
        imageView.layer.cornerRadius = 45 / 2
        imageView.image = UIImage(named: "Myprofile")
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "집밥이지"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let sideLabel: UILabel = {
        let label = UILabel()
        label.text = "님이"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var nickNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, sideLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이번주에 실천한 식재료 제로 웨이스트"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nickNameStackView, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 3
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
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(45)
        }
        
        addSubview(profileStackView)
        profileStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(16)
        }
        
        userNameLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        sideLabel.setContentHuggingPriority(.init(250), for: .horizontal)
    }
}

