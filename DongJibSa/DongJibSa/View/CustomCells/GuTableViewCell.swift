//
//  GuTableViewCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/04.
//

import UIKit

class GuTableViewCell: UITableViewCell {
    static let cellId: String = "GuTableViewCell"
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? .accentColor : .white
        }
    }
    
    var seperateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "강남구"
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
        self.contentView.addSubview(seperateView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(seperateBottonView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        
        seperateView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(1)
        }
        
        seperateBottonView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
