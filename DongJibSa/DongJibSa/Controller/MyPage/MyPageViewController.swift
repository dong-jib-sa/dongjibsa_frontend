//
//  MyPageViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingbuttonTapped))
        navigationItem.title = "내 장바구니"
        navigationController?.navigationBar.tintColor = .headerColor
    }
    
    @objc private func settingbuttonTapped(_ sender: UIButton) {
        print("settings")
    }
    
    private func setupView() {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(MyInfoCell.self, forCellReuseIdentifier: MyInfoCell.cellId)
        myTableView.register(MyRecipeCell.self, forCellReuseIdentifier: MyRecipeCell.cellId)
        myTableView.sectionHeaderTopPadding = .zero
        myTableView.separatorStyle = .none
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 180))
        myTableView.tableHeaderView = headerView
        headerView.backgroundColor = .white
        
        
        let thumbnailImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "mypage")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()

        headerView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
