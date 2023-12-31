//
//  HomeViewController+TableViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/27.
//

import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.cellId, for: indexPath) as! RecipeCell
        cell.selectionStyle = .none
        let imageURL = recipeList[indexPath.row].imgUrl
        cell.recipeImage.setImageURL(imageURL)
        cell.titleLabel.text = recipeList[indexPath.row].title
        cell.locationLabel.text = recipeList[indexPath.row].userName
        cell.participantLabel.text = "1/\(recipeList[indexPath.row].peopleCount)명"
        cell.priceLabel.text = "1인당 예상가 \(recipeList[indexPath.row].pricePerOne)원"
        var recipeIngredients: [String] = []
        for i in 0..<recipeList[indexPath.row].recipeIngredients.count {
            var name: String = recipeList[indexPath.row].recipeIngredients[i].ingredientName
            recipeIngredients.append("#\(name) ")
        }
        cell.tagListLabel.text = recipeIngredients.reduce("", +)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = indexPath.row
        let item = recipeList[id]
        showDetail(for: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
