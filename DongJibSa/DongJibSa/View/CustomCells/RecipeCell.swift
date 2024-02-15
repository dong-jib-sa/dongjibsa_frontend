//
//  RecipeCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/27.
//

import UIKit
import SnapKit

class RecipeCell: UITableViewCell {
    
    static let cellId: String = "RecipeCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "boardDefaultImage")
        imageView.backgroundColor = .accentColor
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    var tagListLabel: UILabel = {
        let label = UILabel()
        label.text = "#새우 #부추 #계란"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .bodyColor
        label.textAlignment = .left
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새우 부추전 파티원 모집합니다."
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .headerColor
        label.textAlignment = .left
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "용궁 놀이터"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .bodyColor
        label.textAlignment = .left
        return label
    }()
    
    var participantLabel: UILabel = {
        let label = UILabel()
        label.text = "2/5명"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .bodyColor
        label.textAlignment = .right
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "1인당 예상가 6500원"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        label.textAlignment = .left
        return label
    }()
    
    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
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
        self.contentView.addSubview(cellView)
        cellView.addSubview(recipeImage)
        cellView.addSubview(tagListLabel)
        cellView.addSubview(titleLabel)
        cellView.addSubview(locationLabel)
        cellView.addSubview(participantLabel)
        cellView.addSubview(priceLabel)
        cellView.addSubview(separatorView)
        
        cellView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(140)
        }
        
        recipeImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        tagListLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImage.snp.top).offset(8)
            make.left.equalTo(recipeImage.snp.right).offset(20)
            make.right.equalToSuperview()
            make.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(tagListLabel.snp.bottom).offset(4)
            make.left.equalTo(recipeImage.snp.right).offset(20)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        locationLabel.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(recipeImage.snp.right).offset(20)
            make.right.equalTo(participantLabel.snp.left)
            make.height.equalTo(15)
        }
        
        participantLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        participantLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.right.equalToSuperview()
            make.height.equalTo(15)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(recipeImage.snp.bottom).offset(-8)
            make.left.equalTo(recipeImage.snp.right).offset(20)
            make.right.equalToSuperview()
            make.height.equalTo(15)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
