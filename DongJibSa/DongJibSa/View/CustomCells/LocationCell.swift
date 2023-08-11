//
//  LocationCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/04.
//

import UIKit

class LocationCell: UICollectionViewCell {
    static let cellId: String = "LocationCell"
    
    let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .accentColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "영등포구"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(_ name: String) {
        titleLabel.text = name
    }
    
    private func setupCell() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(cellView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(removeButton)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
        
        removeButton.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(15)
            make.width.height.equalTo(12)
        }
    }
}
