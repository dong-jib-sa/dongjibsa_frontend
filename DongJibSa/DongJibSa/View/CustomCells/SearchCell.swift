//
//  SearchCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/02.
//

import UIKit

class SearchCell: UICollectionViewCell {
    static let cellId: String = "SearchCell"
    
    let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.text = "한식"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var menuStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [menuImageView, menuLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(_ menu: Menu) {
        menuLabel.text = menu.name
        menuImageView.image = UIImage(named: menu.imageName)
    }
    
    private func setupCell() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(cellView)
        cellView.addSubview(menuStackView)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        menuStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
