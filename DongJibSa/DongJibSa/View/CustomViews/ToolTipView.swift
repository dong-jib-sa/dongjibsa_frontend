//
//  ToolTipView.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/19.
//

import UIKit

class ToolTipView: UIView {
    
    private let toolTip = ToolTip()
    
    private let toolTipView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 10
        view.isHidden = true
        return view
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    
    init(title: String) {
        descriptionLabel.text = title
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(toolTipView)
        toolTipView.addSubview(toolTip)
        toolTipView.addSubview(descriptionLabel)
        toolTipView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        toolTip.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 10, height: 5))
            make.bottom.equalTo(toolTipView.snp.top)
            make.right.equalTo(toolTipView.snp.right).inset(10)
        }
    }
    
}
