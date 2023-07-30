//
//  HomeViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/27.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let floatingActionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accentColor
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .primaryColor
        button.layer.cornerRadius = 65 / 2
        button.layer.shadowOpacity = 0.5
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = .zero
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "상도동", style: .plain, target: self, action: .none)
        navigationController?.navigationBar.tintColor = .headerColor
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.cellId)
        tableView.separatorStyle = .none
        
        self.view.addSubview(floatingActionButton)
        self.view.bringSubviewToFront(floatingActionButton)
        floatingActionButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(100)
            make.height.width.equalTo(65)
        }
        floatingActionButton.addTarget(self, action: #selector(floatingActionButtonTapped), for: .touchUpInside)
    }
    
    @objc func floatingActionButtonTapped(_ sender: UIButton) {
        let addViewController = AddViewController()
        
        let navigationController = UINavigationController(rootViewController: addViewController)
        navigationController.modalPresentationStyle = .fullScreen
        addViewController.navigationItem.title = NSLocalizedString("레시피 파티원 모집하기", comment: "")
        addViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeAddViewController))
        navigationController.navigationBar.tintColor = .bodyColor
        addViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: .none)
        
        self.present(navigationController, animated: true)
    }
    
    @objc func closeAddViewController() {
        self.dismiss(animated: true)
    }
    
    func showDetail(for id: Int) {
        let detail = UIStoryboard.init(name: "Detail", bundle: nil)
        guard let viewController = detail.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        viewController.hidesBottomBarWhenPushed = true
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: .none)
        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backButtonDisplayMode = .minimal
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
