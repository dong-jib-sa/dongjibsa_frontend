//
//  CommentTextFieldHeaderView.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/22.
//

import UIKit

class CommentTextFieldHeaderView: UIView {
    
    let photoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.toStyledTextField(textField)
        textField.placeholder = "댓글을 입력하세요..."
        textField.addPadding(width: 10)
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    lazy var commentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoButton, commentTextField, sendButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .white
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(commentTextField)
        addSubview(commentStackView)
        
        commentTextField.snp.makeConstraints { make in
            make.height.equalTo(38)
        }
        
        commentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        
        photoButton.setContentHuggingPriority(.init(251), for: .horizontal)
        photoButton.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        commentTextField.setContentHuggingPriority(.init(250), for: .horizontal)
        commentTextField.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        sendButton.setContentHuggingPriority(.init(251), for: .horizontal)
        sendButton.setContentCompressionResistancePriority(.init(751), for: .horizontal)
    }
}
