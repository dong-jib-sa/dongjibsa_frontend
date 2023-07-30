//
//  CommentCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/29.
//

import UIKit

class CommentCell: UITableViewCell {
    static let cellId: String = "CommentCell"
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .primaryColor
        imageView.layer.cornerRadius = 40 / 2
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "양념치킨"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "10분 전"
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
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupCell() {
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(profileStackView)
        self.contentView.addSubview(commentLabel)
        self.contentView.addSubview(replyButton)
        
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
        }
    }
}
