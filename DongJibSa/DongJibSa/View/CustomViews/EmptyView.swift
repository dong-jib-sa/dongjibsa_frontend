//
//  EmptyView.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/26.
//

import UIKit

class EmptyView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .accentColor
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 2
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    init(imageName: String, title: String) {
        imageView.image = UIImage(systemName: imageName)
        descriptionLabel.text = title
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
