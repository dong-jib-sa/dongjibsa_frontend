//
//  TextFieldCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    static let cellId: String = "TextFieldCell"
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "레시피 제목을 입력해주세요."
        textField.toStyledTextField(textField)
        textField.addPadding(width: 16)
        return textField
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
        self.contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
}
