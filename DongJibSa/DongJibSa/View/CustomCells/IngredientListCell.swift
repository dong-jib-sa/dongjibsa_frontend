//
//  IngredientListCell.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/22.
//

import UIKit

class IngredientListCell: UITableViewCell {
    static let cellId: String = "IngredientListCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "재료명"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        label.textAlignment = .center
        return label
    }()
    
    let buyLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        label.textAlignment = .center
        return label
    }()
    
    let needLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        label.textAlignment = .center
        return label
    }()
    
    let shareLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, buyLabel, needLabel, shareLabel])
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
        addSubview(stackView)
        
        cellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
