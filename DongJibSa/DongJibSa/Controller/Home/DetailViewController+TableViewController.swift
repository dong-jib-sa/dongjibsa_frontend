//
//  DetailViewController+TableViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == ingredientsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsInfoCell.cellID, for: indexPath) as! IngredientsInfoCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.cellId, for: indexPath) as! CommentCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == ingredientsTableView {
            return 44
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == ingredientsTableView {
            return 44
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        if tableView == ingredientsTableView {
            
            let titleLabel = UILabel()
            titleLabel.text = "재료명"
            titleLabel.font = .systemFont(ofSize: 14)
            titleLabel.textColor = .bodyColor
            titleLabel.textAlignment = .left
            let buyLabel = UILabel()
            buyLabel.text = "구매"
            buyLabel.font = .systemFont(ofSize: 14)
            buyLabel.textColor = .bodyColor
            buyLabel.textAlignment = .center
            let needLabel = UILabel()
            needLabel.text = "필요"
            needLabel.font = .systemFont(ofSize: 14)
            needLabel.textColor = .bodyColor
            needLabel.textAlignment = .center
            let shareLabel = UILabel()
            shareLabel.text = "나눔"
            shareLabel.font = .systemFont(ofSize: 14)
            shareLabel.textColor = .bodyColor
            shareLabel.textAlignment = .center
            
            let amountStackView = UIStackView(arrangedSubviews: [buyLabel, needLabel, shareLabel])
            amountStackView.axis = .horizontal
            amountStackView.distribution = .fillEqually
            amountStackView.alignment = .fill
            
            let stackView = UIStackView(arrangedSubviews: [titleLabel, amountStackView])
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            
            headerView.addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            let seperateView = UIView()
            seperateView.backgroundColor = .systemGray3
            
            headerView.addSubview(seperateView)
            seperateView.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.height.equalTo(1)
                make.left.right.equalToSuperview()
            }
            
            return headerView
        } else {
//            let registeredImageView: UIImageView = {
//                let imageView = UIImageView()
//                imageView.image = UIImage(systemName: "circle.fill")
//                imageView.tintColor = .primaryColor
//                imageView.contentMode = .scaleAspectFit
//                return imageView
//            }()
            
            let registeredButton: UIButton = {
                let button = UIButton()
                button.setTitle("● 등록순", for: .normal)
                button.setTitleColor(.primaryColor, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
                return button
            }()
            
//            let registeredStackView = UIStackView(arrangedSubviews: [registeredImageView, registeredButton])
//            registeredStackView.axis = .horizontal
//            registeredStackView.distribution = .fill
//            registeredStackView.alignment = .center
            
//            let recentImageView: UIImageView = {
//                let imageView = UIImageView()
//                imageView.image = UIImage(systemName: "circle.fill")
//                imageView.tintColor = .primaryColor
//                imageView.contentMode = .scaleAspectFit
//                return imageView
//            }()
            
            let recentButton: UIButton = {
                let button = UIButton()
                button.setTitle("● 최신순", for: .normal)
                button.setTitleColor(.gray, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
                return button
            }()
            
//            let recentStackView = UIStackView(arrangedSubviews: [recentImageView, recentButton])
//            recentStackView.axis = .horizontal
//            recentStackView.distribution = .fill
//            recentStackView.alignment = .center
            
            let emptyView = UIView()
            
            let stackView = UIStackView(arrangedSubviews: [registeredButton, recentButton, emptyView])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.spacing = 10
            
            headerView.addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            return headerView
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
