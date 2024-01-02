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
            if indexPath.row == 0 {
                let calorie: Int = Int(my[indexPath.row])
                cell.resultLabel.text = "\(calorie * 10)kcal"
            } else {
                let sum: Int = Int(my[indexPath.row])
                cell.resultLabel.text = "\(sum / 100)개"
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyRecipeCell.cellId, for: indexPath) as! MyRecipeCell
//            if let imageURL = URL(string: boardList[indexPath.row].imgUrl) {
//                if let imageData = try? Data(contentsOf: imageURL) {
                    cell.recipeImage.setImageURL(recipeList[indexPath.row].imgUrl)
//                }
//            }
            cell.titleLabel.text = recipeList[indexPath.row].title
            cell.locationLabel.text = "집밥이지"
            cell.priceLabel.text = "1인당 예상가 \(recipeList[indexPath.row].pricePerOne)원"
            var recipeIngredients: [String] = []
            for i in 0..<recipeList[indexPath.row].recipeIngredients.count {
                var name: String = recipeList[indexPath.row].recipeIngredients[i].ingredientName
                recipeIngredients.append("#\(name) ")
            }
            cell.tagListLabel.text = recipeIngredients.reduce("", +)
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
