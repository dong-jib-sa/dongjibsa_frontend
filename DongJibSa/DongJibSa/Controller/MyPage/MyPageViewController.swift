//
//  MyPageViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit

final class MyPageViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    let myPageBoardTitleView = MyPageBoardTitleView()
    let myPageProfileView = MyPageProfileView()
    var toggleTableView: Bool = false
    let myPractice: [MyPractice] = MyPractice.list
    var indicator: Indicator?
    var recipeList: [PostDto] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        getMyIndicator()
        getMyRecipeList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissNotification), name: NSNotification.Name("DismissUpdateAndDeleteView"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyIndicator()
        getMyRecipeList()
    }
    
    @objc private func didDismissNotification(_ notification: Notification) {
        getMyRecipeList()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingbuttonTapped))
        navigationItem.title = "내 장바구니"
        navigationController?.navigationBar.tintColor = .headerColor
    }
    
    @objc private func settingbuttonTapped(_ sender: UIButton) {
        let viewController = SettingViewController()
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupView() {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(MyInfoCell.self, forCellReuseIdentifier: MyInfoCell.cellId)
        myTableView.register(MyRecipeCell.self, forCellReuseIdentifier: MyRecipeCell.cellId)
        myTableView.register(EmptyListCell.self, forCellReuseIdentifier: EmptyListCell.cellId)
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
    
    private func getMyIndicator() {
        Network.shared.getMypage { indicator in
            self.indicator = indicator
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }

    private func getMyRecipeList() {
        Network.shared.getMyPosts { board in
            self.recipeList = board
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }
}
