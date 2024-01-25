//
//  IngredientHeaderView.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/22.
//

import UIKit

class IngredientHeaderView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "재료명"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .bodyColor
        label.textAlignment = .left
        return label
    }()
    
    let buyLabel: UILabel = {
        let label = UILabel()
        label.text = "구매"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .bodyColor
        label.textAlignment = .center
        return label
    }()
    
    let needLabel: UILabel = {
        let label = UILabel()
        label.text = "필요"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .bodyColor
        label.textAlignment = .center
        return label
    }()
    
    let shareLabel: UILabel = {
        let label = UILabel()
        label.text = "나눔"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .bodyColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var amountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buyLabel, needLabel, shareLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, amountStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        addSubview(seperateView)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        
        seperateView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
