//
//  CommentCollectionViewCell.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/25.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    static let cellId: String = "CommentCollectionViewCell"
    
    weak var delegate: ButtonTappedDelegate?
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .primaryColor
        imageView.layer.cornerRadius = 40 / 2
        imageView.image = UIImage(named: "Myprofile")
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "집밥이지"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
//        label.text = "10분 전"
        label.text = "방금"
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, timeLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "저요~!! 오늘 저녁 뭐 먹나 했는데, 메뉴 나왔네요!"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let replyButton: UIButton = {
        let button = UIButton()
        button.setTitle("답글쓰기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(replyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func replyButtonTapped(_ sender: UIButton) {
//        delegate?.cellButtonTapped(for: )
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.contentView.addSubview(cellView)
        cellView.addSubview(profileImageView)
        cellView.addSubview(profileStackView)
        cellView.addSubview(commentLabel)
        cellView.addSubview(replyButton)
        
        cellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(16)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileStackView.snp.bottom).offset(10)
            make.left.equalTo(profileStackView.snp.left)
            make.right.equalToSuperview().inset(16)
        }
        
        replyButton.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom)
            make.left.equalTo(commentLabel.snp.left)
            make.width.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
}
