//
//  DetailViewController+TableViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit
import FirebaseDatabase

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return (recipe?.postDto.recipeIngredients.count ?? 0)
        } else if section == 4 {
            return comment.count
        } else if section == 5 {
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipe = recipe else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeContentCell.cellId, for: indexPath) as! RecipeContentCell
            cell.titleLabel.text = recipe.postDto.title
            let createdAt = recipe.postDto.createdAt?.components(separatedBy: "T")
            cell.createdDateLabel.text = createdAt?.first ?? ""
            cell.timeLabel.text = countDay(date: recipe.postDto.createdAt!)
            cell.contentLabel.text = recipe.postDto.content
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeInfoCell.cellId, for: indexPath) as! RecipeInfoCell
            cell.priceLabel.text = "예상가: \(recipe.postDto.expectingPrice)원"
            cell.participantLabel.text = "파티원: \(recipe.postDto.peopleCount)명"
            cell.pricePerPersonLabel.text = "1인당 예상 구매가: \(recipe.postDto.pricePerOne)원"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalorieCell.cellId, for: indexPath) as! CalorieCell
            if recipe.includeCalorie {
                cell.calorieInfoLabel.text = "칼로리가 등록된 레시피에요"
            } else {
                cell.calorieInfoLabel.text = "칼로리가 등록되지 않은 레시피에요"
            }
            cell.descriptionButton.addTarget(self, action: #selector(calorieDescriptionButtonTapped), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsInfoCell.cellId, for: indexPath) as! IngredientsInfoCell
            cell.titleLabel.text = "  \(recipe.postDto.recipeIngredients[indexPath.row].ingredientName)"
            cell.buyLabel.text = "\(Int(recipe.postDto.recipeIngredients[indexPath.row].totalQty))"
            cell.needLabel.text = "\(Int(recipe.postDto.recipeIngredients[indexPath.row].requiredQty))"
            cell.shareLabel.text = "\(Int(recipe.postDto.recipeIngredients[indexPath.row].sharingAvailableQty))"
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.cellId, for: indexPath) as! CommentCell
            cell.userNameLabel.text = self.comment[indexPath.row]["userName"]
            cell.commentLabel.text = self.comment[indexPath.row]["comment"]
            if let dateTime = self.comment[indexPath.item]["createdAt"]!.dateLong as? Date {
                cell.timeLabel.text = dateTime.dayAndTimeText
            }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc func calorieDescriptionButtonTapped(_ sender: UIButton) {
        sender.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.isSelected = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else if indexPath.section == 1 {
            return 80
        } else if indexPath.section == 2 {
            return 24
        } else if indexPath.section == 3 {
            return 44
        } else if indexPath.section == 4 {
            return UITableView.automaticDimension
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 65
        } else if section == 3 {
            return 44
        } else if section == 4 {
            return 65
        } else if section == 5 {
            return 50
        } else {
            return .leastNonzeroMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        if section == 0 {
            headerView.addSubview(profileHeaderView)
            profileHeaderView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            profileHeaderView.userNameLabel.text = recipe?.postDto.member?.nickName
            
            return headerView
            
        } else if section == 3 {
            headerView.addSubview(ingredientHeaderView)
            ingredientHeaderView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            return headerView
            
        } else if section == 4 {
            headerView.addSubview(commentHeaderView)
            commentHeaderView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            commentHeaderView.talkLabel.text = "\(commentCount)"
            return headerView
            
        } else if section == 5 {
            headerView.addSubview(commentTextFieldHeaderView)
            commentTextFieldHeaderView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            commentTextFieldHeaderView.sendButton.addTarget(self, action: #selector(commentAddButtonTapped), for: .touchUpInside)
            
            return headerView
        } else {
            return headerView
        }   
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5 {
            return .leastNonzeroMagnitude
        }
        return .zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    private func countDay(date: String) -> String {
        if let creadtedAt = date.components(separatedBy: "T").first {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let creadtedDay = formatter.date(from: creadtedAt) {
                let numberOfDays = Calendar.current.dateComponents([.day], from: creadtedDay, to: Date())
                if numberOfDays.day! == 0 {
                    return "오늘"
                }
                return "\(numberOfDays.day!)일 전"
            }
        }
        return ""
    }
}
