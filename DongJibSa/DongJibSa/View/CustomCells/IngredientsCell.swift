//
//  IngredientsCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/28.
//

import UIKit

class IngredientsCell: UITableViewCell {
    
    static let cellID: String = "IngredientsCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    var titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    var titleTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        return textField
    }()
    
    var buyView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    var buyTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        return textField
    }()
    
    var needView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    var needTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        return textField
    }()
    
    var shareView: UIView = {
        let view = UIView()
        return view
    }()
    
    var shareTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleView, buyView, needView, shareView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
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
        self.contentView.addSubview(cellView)
        cellView.addSubview(stackView)
        titleView.addSubview(titleTextField)
        buyView.addSubview(buyTextField)
        needView.addSubview(needTextField)
        shareView.addSubview(shareTextField)
        
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        buyTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        needTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        shareTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
