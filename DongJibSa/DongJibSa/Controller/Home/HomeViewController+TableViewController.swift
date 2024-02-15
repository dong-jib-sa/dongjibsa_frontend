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
        if let imageURL = recipeList[indexPath.row].postDto.imgUrls {
            cell.recipeImage.setImageURL(imageURL[0])
        }
        cell.titleLabel.text = recipeList[indexPath.row].postDto.title
        cell.locationLabel.text = recipeList[indexPath.row].postDto.member?.nickName
        cell.participantLabel.text = "1/\(recipeList[indexPath.row].postDto.peopleCount)명"
        cell.priceLabel.text = "1인당 예상가 \(recipeList[indexPath.row].postDto.pricePerOne)원"
        var recipeIngredients: [String] = []
        for i in 0..<recipeList[indexPath.row].postDto.recipeIngredients.count {
            let name: String = recipeList[indexPath.row].postDto.recipeIngredients[i].ingredientName
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
    
    private func showDetail(for recipeInfo: PostDto) {
        let detail = UIStoryboard.init(name: "Detail", bundle: nil)
        guard let viewController = detail.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        viewController.recipeId = recipeInfo.postDto.id
        viewController.recipe = recipeInfo
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backButtonDisplayMode = .minimal
    }
}
