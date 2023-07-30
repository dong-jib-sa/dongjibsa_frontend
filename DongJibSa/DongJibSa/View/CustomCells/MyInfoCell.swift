//
//  MyInfoCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit

class MyInfoCell: UITableViewCell {
    static let cellId: String = "MyInfoCell"
    
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = .zero
        view.backgroundColor = .white
        return view
    }()
    
    let itemView: UIView = {
        let view = UIView()
        view.backgroundColor = .accentColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .primaryColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이번주 내가 버리지 않고\n나눔한 식재료 수량"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        label.setLineSpacing(spacing: 3)
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0000개"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, resultLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
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
        self.contentView.addSubview(cardView)
        cardView.addSubview(itemView)
        itemView.addSubview(itemImageView)
        cardView.addSubview(infoStackView)
        
        cardView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(90)
        }
        
        itemView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(40)
        }
        
        itemImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        infoStackView.snp.makeConstraints { make in
            make.centerY.equalTo(itemView.snp.centerY)
            make.left.equalTo(itemView.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        descriptionLabel.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        resultLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
    }
}
