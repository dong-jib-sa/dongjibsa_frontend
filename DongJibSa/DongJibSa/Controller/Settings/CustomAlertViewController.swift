//
//  CustomAlertViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/12/30.
//

import UIKit

protocol CustomAlertDelegate {
    func action()
    func exit()
}

enum CustomAlertType {
    case onlyDone
    case doneAndCancel
}

class CustomAlertViewController: UIViewController {
    
    lazy var backgroudView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = mainTitle
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = content
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var greenColorButton: UIButton = {
        let button = UIButton()
        button.setTitle(greenColorButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.backgroundColor = .primaryColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(greenColorButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var grayColorButton: UIButton = {
        let button = UIButton()
        button.setTitle(grayColorButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(grayColorButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greenColorButton, grayColorButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    var mainTitle: String
    var content: String
    var greenColorButtonTitle: String
    var grayColorButtonTitle: String
    var customAlertType: CustomAlertType
    var height: Int
    
    var delegate: CustomAlertDelegate?
    
    init(title: String, content: String? = nil, greenColorButtonTitle: String? = nil, grayColorButtonTitle: String? = nil, customAlertType: CustomAlertType, alertHeight: Int) {
        self.mainTitle = title
        self.content = content ?? ""
        self.greenColorButtonTitle = greenColorButtonTitle ?? ""
        self.grayColorButtonTitle = grayColorButtonTitle ?? ""
        self.customAlertType = customAlertType
        self.height = alertHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        setCustomAlertView()
        
        switch customAlertType {
        case .onlyDone:
            grayColorButton.isHidden = false
            greenColorButton.isHidden = true
        case .doneAndCancel:
            grayColorButton.isHidden = false
            greenColorButton.isHidden = false
        }
    }
    
    private func setCustomAlertView() {
        self.view.addSubview(backgroudView)
        backgroudView.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(contentLabel)
        mainView.addSubview(buttonStackView)
        
        backgroudView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(self.height)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(65)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(38)
        }
    }
    
    @objc func greenColorButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.exit()
        }
    }
    
    @objc func grayColorButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.action()
        }
    }
}
