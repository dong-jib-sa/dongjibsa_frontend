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
            return myPractice.count
        } else {
            return recipeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoCell.cellId, for: indexPath) as! MyInfoCell
            cell.itemImageView.image = UIImage(named: myPractice[indexPath.row].item)
            cell.descriptionLabel.text = myPractice[indexPath.row].description
            cell.resultLabel.text = myPractice[indexPath.row].result
            guard let indicator = indicator else { return cell }
            if indexPath.row == 0 {
                let calorie: Double = indicator.calorieAvg
                cell.resultLabel.text = "\(calorie)kcal"
            } else {
                let sum: Double = indicator.sumOfSharingAvailableQty
                cell.resultLabel.text = "\(sum)개"
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyRecipeCell.cellId, for: indexPath) as! MyRecipeCell
//            if let imageURL = URL(string: boardList[indexPath.row].imgUrl) {
//                if let imageData = try? Data(contentsOf: imageURL) {
            cell.recipeImage.setImageURL(recipeList[indexPath.row].postDto.imgUrls?[0] ?? "")
//                }
//            }
            cell.titleLabel.text = recipeList[indexPath.row].postDto.title
            let nickName = UserDefaults.standard.string(forKey: "UserNickName")
            cell.locationLabel.text = nickName
            cell.priceLabel.text = "1인당 예상가 \(recipeList[indexPath.row].postDto.pricePerOne)원"
            var recipeIngredients: [String] = []
            for i in 0..<recipeList[indexPath.row].postDto.recipeIngredients.count {
                var name: String = recipeList[indexPath.row].postDto.recipeIngredients[i].ingredientName
                recipeIngredients.append("#\(name) ")
            }
            cell.tagListLabel.text = recipeIngredients.reduce("", +)
            cell.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        if section == 0 {
            headerView.addSubview(myPageProfileView)
            myPageProfileView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            return headerView
        } else {
            headerView.addSubview(myPageBoardTitleView)
            myPageBoardTitleView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            myPageBoardTitleView.writtenBoardListButton.addTarget(self, action: #selector(writtenButtonTapped), for: .touchUpInside)
            myPageBoardTitleView.purchasedBoardListButton.addTarget(self, action: #selector(purchasedButtonTapped), for: .touchUpInside)
            
            return headerView
        }
    }
    
    @objc func writtenButtonTapped() {
        toggleTableView = false
        myPageBoardTitleView.purchasedUnderLineView.isHidden = true
        myPageBoardTitleView.purchasedBoardListButton.setTitleColor(.systemGray, for: .normal)
        myPageBoardTitleView.writtenUnderLineView.isHidden = false
        myPageBoardTitleView.writtenBoardListButton.setTitleColor(.black, for: .normal)
        self.myTableView.reloadData()
    }
    
    @objc func purchasedButtonTapped() {
        toggleTableView = true
        myPageBoardTitleView.purchasedUnderLineView.isHidden = false
        myPageBoardTitleView.purchasedBoardListButton.setTitleColor(.black, for: .normal)
        myPageBoardTitleView.writtenUnderLineView.isHidden = true
        myPageBoardTitleView.writtenBoardListButton.setTitleColor(.systemGray, for: .normal)
        self.myTableView.reloadData()
    }
    
    @objc func moreButtonTapped(_ sender: UIButton) {
        let viewController = UpdateAndDeleteViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
//        viewController.postId = 0
        self.present(viewController, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? MyRecipeCell else {
            return
        }
        let row = indexPath.row
        let viewController = UpdateAndDeleteViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        viewController.postDto = recipeList[row]
        self.present(viewController, animated: true)
        
    }
}
