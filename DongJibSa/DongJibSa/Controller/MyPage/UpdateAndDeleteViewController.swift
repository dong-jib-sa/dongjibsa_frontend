//
//  UpdateAndDeleteViewController.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/02.
//

import UIKit

class UpdateAndDeleteViewController: UIViewController {
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    let updateButton: UIButton = {
        var attString = AttributedString("게시글 수정하기")
        attString.font = .systemFont(ofSize: 16)
        attString.foregroundColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
        configuration.imagePadding = 16
        configuration.baseForegroundColor = .black
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .primaryColor
        button.contentHorizontalAlignment = .leading
        button.isSelected = false
        return button
    }()
    
    let deleteButton: UIButton = {
        var attString = AttributedString("게시글 삭제하기")
        attString.font = .systemFont(ofSize: 16)
        attString.foregroundColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
        configuration.imagePadding = 16
        configuration.baseForegroundColor = .black
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .primaryColor
        button.contentHorizontalAlignment = .leading
        button.isSelected = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [updateButton, deleteButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // MEMO: 배경 터치시 현재 뷰 컨트롤러 내리기
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true)
        }
    }
    
    func setupView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(160)
        }
        mainView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func updateButtonTapped(_ sender: UIButton) {
        print("게시글 수정")
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        print("게시글 삭제")
    }
}
