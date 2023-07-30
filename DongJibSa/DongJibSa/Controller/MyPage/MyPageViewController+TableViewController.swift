//
//  MyPageViewController+TableViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoCell.cellId, for: indexPath) as! MyInfoCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyRecipeCell.cellId, for: indexPath) as! MyRecipeCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        if section == 0 {
            let profileImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.backgroundColor = .primaryColor
                imageView.layer.cornerRadius = 45 / 2
                return imageView
            }()
            
            headerView.addSubview(profileImageView)
            profileImageView.snp.makeConstraints { make in
                make.top.equalTo(headerView.snp.top).offset(10)
                make.left.equalToSuperview().inset(16)
                make.width.height.equalTo(45)
            }
            
            let userNameLabel: UILabel = {
                let label = UILabel()
                label.text = "집밥이지"
                label.font = .boldSystemFont(ofSize: 14)
                return label
            }()
            
            let sideLabel: UILabel = {
                let label = UILabel()
                label.text = "님이"
                label.font = .systemFont(ofSize: 14)
                return label
            }()
            
            let nickNameStackView: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [userNameLabel, sideLabel])
                stackView.axis = .horizontal
                stackView.distribution = .fill
                stackView.alignment = .fill
                return stackView
            }()
            
            let descriptionLabel: UILabel = {
                let label = UILabel()
                label.text = "실천한 식재료 제로 웨이스트"
                label.font = .systemFont(ofSize: 14)
                return label
            }()
            
            let profileStackView: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [nickNameStackView, descriptionLabel])
                stackView.axis = .vertical
                stackView.distribution = .fillEqually
                stackView.alignment = .fill
                return stackView
            }()
            
            headerView.addSubview(profileStackView)
            profileStackView.snp.makeConstraints { make in
                make.centerY.equalTo(profileImageView.snp.centerY)
                make.left.equalTo(profileImageView.snp.right).offset(10)
                make.right.equalToSuperview().inset(16)
            }
            
            return headerView
        } else {
            let titleLabel: UILabel = {
                let label = UILabel()
                label.text = "내가 구매한 레시피"
                label.font = .boldSystemFont(ofSize: 16)
                return label
            }()
            
            headerView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview().offset(10)
                make.left.right.equalToSuperview().inset(16)
            }
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 65
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 140
        }
    }
}
