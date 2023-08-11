//
//  DongTableViewCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/04.
//

import UIKit

class DongTableViewCell: UITableViewCell {
    static let cellId: String = "DongTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "개포동"
//        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    var seperateBottonView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
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
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(seperateBottonView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        
        seperateBottonView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.contentView.backgroundColor = .accentColor
        } else {
            self.contentView.backgroundColor = .white
        }
    }
}
