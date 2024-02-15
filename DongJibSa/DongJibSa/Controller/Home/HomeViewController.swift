//
//  HomeViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/27.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var recipeList: [PostDto] = PostDto.dummyDataList
    
    private lazy var floatingActionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accentColor
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .primaryColor
        button.layer.cornerRadius = 65 / 2
        button.layer.shadowOpacity = 0.5
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = .zero
        view.addSubview(button)
        button.addTarget(self, action: #selector(floatingActionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getRecipeList()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "우리동네 장바구니", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .headerColor
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.cellId)
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        
        floatingActionButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(65)
        }
    }
    
    @objc private func floatingActionButtonTapped(_ sender: UIButton) {
        let addViewController = AddRecipeViewController(navigationController: self.navigationController)
        let navigationController = UINavigationController(rootViewController: addViewController)
        navigationController.modalPresentationStyle = .fullScreen
        addViewController.navigationItem.title = NSLocalizedString("레시피 파티원 모집하기", comment: "")
        addViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeAddViewController))
        navigationController.navigationBar.tintColor = .bodyColor
        
        self.present(navigationController, animated: true)
    }
    
    @objc private func closeAddViewController() {
        self.dismiss(animated: true)
    }
    
    private func getRecipeList() {
        Network.shared.getRecipes { recipeList in
//            self.recipeList = recipeList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
