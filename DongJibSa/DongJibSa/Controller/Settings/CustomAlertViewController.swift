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
    
    lazy var dot1Label: UILabel = {
        let label = UILabel()
        label.text = "• "
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        return label
    }()
    
    let empty1View: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var dot1TopStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dot1Label, empty1View])
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var content1Label: UILabel = {
        let label = UILabel()
        label.text = "탈퇴하면 모든 정보(계정, 게시글)가 삭제되며 복구되지 않습니다."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dot2Label: UILabel = {
        let label = UILabel()
        label.text = "• "
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        return label
    }()
    
    lazy var content2Label: UILabel = {
        let label = UILabel()
        label.text = "작성한 댓글은 삭제되지 않습니다."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        return label
    }()
    
    lazy var dot3Label: UILabel = {
        let label = UILabel()
        label.text = "• "
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        return label
    }()
    
    lazy var content3Label: UILabel = {
        let label = UILabel()
        label.text = "연동된 SNS 계정은 함께 탈퇴됩니다."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        return label
    }()
    
    lazy var dot4Label: UILabel = {
        let label = UILabel()
        label.text = "• "
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        return label
    }()
    
    let empty4View: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var dotTopStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dot4Label, empty4View])
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var content4Label: UILabel = {
        let label = UILabel()
        label.text = "단, 관련 법령에 의거하여 일정 기간 정보를 보유할 필요가 있을 경우 법이 정한 기간 동안 해당 정보를 보유합니다."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .bodyColor
        label.numberOfLines = 0
        return label
    }()
    
    lazy var content1StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dot1TopStackView, content1Label])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var content2StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dot2Label, content2Label])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var content3StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dot3Label, content3Label])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var content4StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dotTopStackView, content4Label])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [content1StackView, content2StackView, content3StackView, content4StackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
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
    var greenColorButtonTitle: String
    var grayColorButtonTitle: String
    var customAlertType: CustomAlertType
    var height: Int
    
    var delegate: CustomAlertDelegate?
    
    init(title: String, greenColorButtonTitle: String? = nil, grayColorButtonTitle: String? = nil, customAlertType: CustomAlertType, alertHeight: Int) {
        self.mainTitle = title
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
        mainView.addSubview(contentStackView)
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
//        dot1Label.setContentCompressionResistancePriority(.init(1000), for: .vertical)
//        dot4Label.snp.makeConstraints { make in
//            make.bottom.greaterThanOrEqualToSuperview()
//        }
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
//            make.height.equalTo(160)
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
