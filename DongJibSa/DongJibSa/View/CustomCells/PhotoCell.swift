//
//  PhotoCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/27.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let cellId: String = "PhotoCell"
    
    let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.contentView.addSubview(cellView)
        cellView.addSubview(imageView)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
