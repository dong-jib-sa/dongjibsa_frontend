//
//  RecipeTitleCell.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/22.
//

import UIKit

class RecipeTitleCell: UITableViewCell {
    static let cellId: String = "RecipeTitleCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.text = "새우 부추전 파티원 모집합니다."
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    let createdDateLabel: UILabel = {
        let label = UILabel()
//        label.text = "2023.08.06."
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
//        label.text = "1시간 전"
//        label.text = "방금"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    lazy var timeLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [createdDateLabel, timeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.contentView.addSubview(cellView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(timeLineStackView)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        timeLineStackView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
    }
}
