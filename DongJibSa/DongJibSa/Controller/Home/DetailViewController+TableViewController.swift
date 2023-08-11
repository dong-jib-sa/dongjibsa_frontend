//
//  DetailViewController+TableViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 2 {
            return table
        } else if section == 3 {
            return 0
        } else {
            return (recipeInfo?.recipeIngredients.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeInfoCell.cellId, for: indexPath) as! RecipeInfoCell
            cell.titleLabel.text = recipeInfo?.title
//            cell.writeDateLabel.text =
//            cell.timeLabel.text
            cell.detailLabel.text = recipeInfo?.content
            cell.priceLabel.text = "예상가: \(recipeInfo?.expectingPrice ?? 0)원"
            cell.participantLabel.text = "파티원: \(recipeInfo?.peopleCount ?? 4)명"
            cell.pricePerPersonLabel.text = "1인당 예상 구매가: \(recipeInfo?.pricePerOne ?? 0)원"
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsInfoCell.cellId, for: indexPath) as! IngredientsInfoCell
            cell.titleLabel.text = "  \(recipeInfo?.recipeIngredients[indexPath.row].ingredientName ?? "")"
            cell.buyLabel.text = "\(recipeInfo?.recipeIngredients[indexPath.row].totalQty ?? 0)"
            cell.needLabel.text = "\(recipeInfo?.recipeIngredients[indexPath.row].requiredQty ?? 0)"
            cell.shareLabel.text = "\(recipeInfo?.recipeIngredients[indexPath.row].sharingAvailableQty ?? 0)"
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.cellId, for: indexPath) as! CommentCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.cellId, for: indexPath) as! EmptyCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
          return 250
        } else if indexPath.section == 1 {
            return 44
        } else if indexPath.section == 2 {
            return 100
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 44
        } else if section == 3 {
            return 50
        } else {
            return 65
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
                imageView.image = UIImage(named: "Myprofile")
                return imageView
            }()
            
            headerView.addSubview(profileImageView)
            profileImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().inset(16)
                make.width.height.equalTo(45)
            }
            
            let userNameLabel: UILabel = {
                let label = UILabel()
                label.text = recipeInfo?.userName
                label.font = .boldSystemFont(ofSize: 16)
                return label
            }()
            
            let myLocation = UserDefaults.standard.string(forKey: "myLocation") ?? "정릉4동"
            let descriptionLabel: UILabel = {
                let label = UILabel()
                label.text = myLocation
                label.font = .systemFont(ofSize: 14)
                return label
            }()
            
            let profileStackView: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [userNameLabel, descriptionLabel])
                stackView.axis = .vertical
                stackView.distribution = .fillEqually
                stackView.alignment = .fill
                stackView.spacing = 3
                return stackView
            }()
            
            headerView.addSubview(profileStackView)
            profileStackView.snp.makeConstraints { make in
                make.centerY.equalTo(profileImageView.snp.centerY)
                make.left.equalTo(profileImageView.snp.right).offset(10)
                make.right.equalToSuperview().inset(16)
            }
            
            return headerView
            
        } else if section == 1 {
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
                make.center.equalToSuperview()
                make.left.right.equalToSuperview().inset(16)
            }
            
            let seperateView = UIView()
            seperateView.backgroundColor = .systemGray3
            
            headerView.addSubview(seperateView)
            seperateView.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.height.equalTo(1)
                make.left.right.equalToSuperview().inset(16)
            }
            
            return headerView
            
        } else if section == 2 {
            let likeImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(systemName: "heart.fill")
                imageView.tintColor = .gray
                return imageView
            }()
            
            let likeLabel: UILabel = {
                let label = UILabel()
                label.text = "0"
                label.textColor = .gray
                label.font = .systemFont(ofSize: 12)
                return label
            }()
            
            let likeStackView: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [likeImageView, likeLabel])
                stackView.axis = .horizontal
                stackView.distribution = .fill
                stackView.alignment = .fill
                stackView.spacing = 8
                return stackView
            }()
            
            let talkImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(systemName: "message")
                imageView.tintColor = .gray
                return imageView
            }()
            
            let talkLabel: UILabel = {
                let label = UILabel()
                label.text = "3"
                label.textColor = .gray
                label.font = .systemFont(ofSize: 12)
                return label
            }()
            
            let talkStackView: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [talkImageView, talkLabel])
                stackView.axis = .horizontal
                stackView.distribution = .fill
                stackView.alignment = .fill
                stackView.spacing = 8
                return stackView
            }()
            
            let viewImageView: UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(systemName: "eye")
                imageView.tintColor = .gray
                return imageView
            }()
            
            let viewLabel: UILabel = {
                let label = UILabel()
                label.text = "1"
                label.textColor = .gray
                label.font = .systemFont(ofSize: 12)
                return label
            }()
            
            let viewStackView: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [viewImageView, viewLabel])
                stackView.axis = .horizontal
                stackView.distribution = .fill
                stackView.alignment = .fill
                stackView.spacing = 8
                return stackView
            }()
            
            let emptyView: UIView = {
                let view = UIView()
                return view
            }()
            
            let listStackView: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [likeStackView, talkStackView, emptyView, viewStackView])
                stackView.axis = .horizontal
                stackView.distribution = .fill
                stackView.alignment = .fill
                stackView.spacing = 20
                return stackView
            }()
            
            headerView.addSubview(listStackView)
            listStackView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(4)
                make.left.right.equalToSuperview().inset(16)
            }
            
            let seperateView: UIView = {
                let view = UIView()
                view.backgroundColor = .systemGray3
                return view
            }()
            
            headerView.addSubview(seperateView)
            seperateView.snp.makeConstraints { make in
                make.top.equalTo(listStackView.snp.bottom).offset(5)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(1)
            }
            
            let registeredButton: UIButton = {
                let button = UIButton()
                button.setTitle("● 등록순", for: .normal)
                button.setTitleColor(.primaryColor, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
                return button
            }()
            
            let recentButton: UIButton = {
                let button = UIButton()
                button.setTitle("● 최신순", for: .normal)
                button.setTitleColor(.gray, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
                return button
            }()
            
            let emptyView2 = UIView()
            
            let stackView = UIStackView(arrangedSubviews: [registeredButton, recentButton, emptyView2])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.spacing = 10
            
            headerView.addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.top.equalTo(seperateView.snp.bottom).offset(5)
                make.left.right.equalToSuperview().inset(16)
            }
            
            return headerView
            
        } else {
            let photoButton: UIButton = {
                let button = UIButton()
                button.setImage(UIImage(systemName: "photo"), for: .normal)
                button.tintColor = .gray
                return button
            }()
            
            self.commentTextField.snp.makeConstraints { make in
                make.height.equalTo(38)
            }
            
            let sendButton: UIButton = {
                let button = UIButton()
                button.setImage(UIImage(systemName: "paperplane"), for: .normal)
                button.tintColor = .gray
                return button
            }()
            
            sendButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            
            let commentStackView: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [photoButton, commentTextField, sendButton])
                stackView.axis = .horizontal
                stackView.distribution = .fill
                stackView.alignment = .fill
                stackView.spacing = 10
                stackView.backgroundColor = .white
                return stackView
            }()

            headerView.addSubview(commentStackView)
            commentStackView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.left.right.equalToSuperview().inset(16)
            }
            photoButton.setContentHuggingPriority(.init(251), for: .horizontal)
            photoButton.setContentCompressionResistancePriority(.init(751), for: .horizontal)
            commentTextField.setContentHuggingPriority(.init(250), for: .horizontal)
            commentTextField.setContentCompressionResistancePriority(.init(750), for: .horizontal)
            sendButton.setContentHuggingPriority(.init(251), for: .horizontal)
            sendButton.setContentCompressionResistancePriority(.init(751), for: .horizontal)
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
