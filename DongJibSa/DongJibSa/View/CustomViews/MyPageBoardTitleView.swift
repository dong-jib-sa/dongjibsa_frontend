//
//  MyPageBoardTitleView.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/02.
//

import UIKit

class MyPageBoardTitleView: UIView {
    
    let writtenBoardTitleView: UIView = {
        let view = UIView()
        return view
    }()
    
    let writtenBoardListButton: UIButton = {
        let button = UIButton()
        button.setTitle("내가 작성한 게시글", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    let writtenUnderLineView: UIView = {
        let view = UIView()
        view.isHidden = false
        view.backgroundColor = .primaryColor
        return view
    }()
    
    lazy var writtenStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [writtenBoardTitleView])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let purchasedBoardTitleView: UIView = {
        let view = UIView()
        return view
    }()
    
    let purchasedBoardListButton: UIButton = {
        let button = UIButton()
        button.setTitle("내가 구매한 게시글", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    let purchasedUnderLineView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .primaryColor
        return view
    }()
    
    lazy var purchasedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [purchasedBoardTitleView])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [writtenStackView, purchasedStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        
        writtenBoardTitleView.addSubview(writtenBoardListButton)
        writtenBoardListButton.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(2)
        }
        
        writtenBoardTitleView.addSubview(writtenUnderLineView)
        writtenUnderLineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(125)
            make.height.equalTo(2)
        }
        
        purchasedStackView.addSubview(purchasedBoardListButton)
        purchasedBoardListButton.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(2)
        }
        
        purchasedStackView.addSubview(purchasedUnderLineView)
        purchasedUnderLineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(125)
            make.height.equalTo(2)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
