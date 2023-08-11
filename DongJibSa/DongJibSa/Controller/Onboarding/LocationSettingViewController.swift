//
//  LocationSettingViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/04.
//

import UIKit

class LocationSettingViewController: UIViewController {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let guTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = .zero
        tableView.sectionHeaderHeight = .zero
        tableView.sectionFooterHeight = .zero
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let dongTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = .zero
        tableView.sectionHeaderHeight = .zero
        tableView.sectionFooterHeight = .zero
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    let guLocation: [String] = ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "자치구", "종로구", "중구", "중랑구"]
    let dongLocation: [String] = ["개포1동", "개포2동", "개포3동", "개포4동", "논현1동", "논현2동", "대치1동", "대치2동", "대치3동", "대치4동", "도곡1동", "도곡2동", "삼성1동", "삼성2동", "세곡동", "수서동", "신사동", "압구정동", "역삼1동", "역삼2동", "일원본동", "일원1동", "청담동"]
    
    var selectLocation: [String] = []
    
    init(selectLocation: [String]) {
        self.selectLocation = selectLocation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        navigationItem.title = "내 동네 설정하기"
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(140)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LocationCell.self, forCellWithReuseIdentifier: LocationCell.cellId)
        
        let seoulView: UIView = {
            let view = UIView()
            return view
        }()
        
        self.view.addSubview(seoulView)
        seoulView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        let seperateTopView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            return view
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "서울"
            return label
        }()
        
        let seperateBottonView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            return view
        }()
        
        seoulView.addSubview(seperateTopView)
        seoulView.addSubview(seperateBottonView)
        seoulView.addSubview(titleLabel)
        seperateTopView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        
        seperateBottonView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        lazy var stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [guTableView, dongTableView])
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            return stackView
        }()
        
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
        
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(seoulView.snp.bottom)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(saveButton.snp.top).offset(-30)
        }
        
        
        let seperateView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            return view
        }()
        
        self.view.addSubview(seperateView)
        seperateView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        guTableView.delegate = self
        guTableView.dataSource = self
        guTableView.register(GuTableViewCell.self, forCellReuseIdentifier: GuTableViewCell.cellId)
        dongTableView.delegate = self
        dongTableView.dataSource = self
        dongTableView.register(DongTableViewCell.self, forCellReuseIdentifier: DongTableViewCell.cellId)
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        let myLocation: String = selectLocation[0]
        UserDefaults.standard.set(myLocation, forKey: "myLocation")
        print(UserDefaults.standard.string(forKey: "myLocation")!)
        
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = main.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false)
    }
}
