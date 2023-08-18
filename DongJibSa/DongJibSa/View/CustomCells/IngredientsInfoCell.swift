//
//  IngredientsInfoCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/28.
//

import UIKit

class IngredientsInfoCell: UITableViewCell {
    static let cellId: String = "IngredientsInfoCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = .primaryColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = " 양배추"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    var buyView: UIView = {
        let view = UIView()
        return view
    }()
    
    var buyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "2"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    var needView: UIView = {
        let view = UIView()
        return view
    }()
    
    var needLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "1"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    var shareView: UIView = {
        let view = UIView()
        return view
    }()
    
    var shareEmphasisView: UIView = {
        let view = UIView()
        view.backgroundColor = .accentColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    var shareLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var amountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buyView, needView, shareView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleView, amountStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setupCell() {
        self.contentView.addSubview(cellView)
        cellView.addSubview(stackView)
        titleView.addSubview(titleStackView)
        buyView.addSubview(buyLabel)
        needView.addSubview(needLabel)
        shareView.addSubview(shareEmphasisView)
        shareEmphasisView.addSubview(shareLabel)
        cellView.addSubview(emptyView)
        
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        buyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        needLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        shareEmphasisView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(30)
        }
        
        shareLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

}
