//
//  CommentHeaderView.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/22.
//

import UIKit

class CommentHeaderView: UIView {
    
    let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .gray
        return imageView
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var likeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeImageView, likeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let talkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "message")
        imageView.tintColor = .gray
        return imageView
    }()
    
    let talkLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var talkStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [talkImageView, talkLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let viewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "eye")
        imageView.tintColor = .gray
        return imageView
    }()
    
    let viewLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var viewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [viewImageView, viewLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var listStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeStackView, talkStackView, emptyView, viewStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    let registeredButton: UIButton = {
        let button = UIButton()
        button.setTitle("● 등록순", for: .normal)
        button.setTitleColor(.primaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        return button
    }()
    
    let recentButton: UIButton = {
        let button = UIButton()
//        button.setTitle("● 최신순", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        return button
    }()
    
    let emptyView2 = UIView()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registeredButton, recentButton, emptyView2])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(listStackView)
        addSubview(seperateView)
        addSubview(stackView)
        
        listStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.right.equalToSuperview().inset(16)
        }
        seperateView.snp.makeConstraints { make in
            make.top.equalTo(listStackView.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(seperateView.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
