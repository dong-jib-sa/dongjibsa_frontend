//
//  DetailTextViewCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit

class DetailTextViewCell: UITableViewCell {

    static let cellId: String = "DetailTextViewCell"
    
    let placeholder: String = "상세내용을 작성해주세요."
    lazy var detailTextView: UITextView = {
        let textView = UITextView()
        textView.text = placeholder
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .systemGray3
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 10
        textView.isScrollEnabled = false
        return textView
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
        self.contentView.addSubview(detailTextView)
        detailTextView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(140)
        }
    }
}
