//
//  ProfileHeaderView.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/22.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .primaryColor
        imageView.layer.cornerRadius = Constant.shared.profileCornerRadius
        imageView.image = UIImage(named: "Myprofile")
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(45)
        }
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(16)
        }
    }
}
