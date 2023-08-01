//
//  AddRecipeViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import UIKit
import PhotosUI

class AddRecipeViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = .zero
        tableView.sectionHeaderHeight = 30
        tableView.sectionFooterHeight = 0
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var photoList: [UIImage] = []
    var table: Int = 1
    var navigation: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        super.init(nibName: nil, bundle: nil)
        self.navigation = navigationController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewTappedKeyboardCancel()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = .zero
            tableView.scrollIndicatorInsets = .zero
        }
    }
    
    private func viewTappedKeyboardCancel() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.cellId)
        tableView.register(IngredientsCell.self, forCellReuseIdentifier: IngredientsCell.cellID)
        tableView.register(DoneButtonCell.self, forCellReuseIdentifier: DoneButtonCell.cellId)
        tableView.register(DetailTextViewCell.self, forCellReuseIdentifier: DetailTextViewCell.cellId)
        tableView.register(EmptyCell.self, forCellReuseIdentifier: EmptyCell.cellId)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 120))
        tableView.tableHeaderView = headerView
        
        let photoButton = UIButton()
        headerView.addSubview(photoButton)
        photoButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(80)
        }
        photoButton.setImage(UIImage(systemName: "camera"), for: .normal)
        photoButton.tintColor = .bodyColor
        photoButton.layer.borderWidth = 0.5
        photoButton.layer.borderColor = UIColor.bodyColor.cgColor
        photoButton.layer.cornerRadius = 10
        photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        
        
        headerView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(photoButton.snp.top)
            make.left.equalTo(photoButton.snp.right).offset(10)
            make.right.equalToSuperview()
            make.bottom.equalTo(photoButton.snp.bottom)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.cellId)
    }
    
    @objc func addButtonTapped(_ sender: UIButton) {
        table += 1
        tableView.insertRows(at: [IndexPath(row: table - 1, section: 4)], with: .bottom)
        tableView.reloadRows(at: [IndexPath(row: table - 1, section: 4)], with: .bottom)
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            let detail = UIStoryboard.init(name: "Detail", bundle: nil)
            guard let viewController = detail.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
                return
            }
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: .none)
            viewController.hidesBottomBarWhenPushed = true
            self.navigation?.navigationItem.backButtonDisplayMode = .minimal
            self.navigation?.pushViewController(viewController, animated: false)
        }
    }
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension AddRecipeViewController: PHPickerViewControllerDelegate {
    @objc private func photoButtonTapped(_ sender: UIButton) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        if !(results.isEmpty) {
            photoList.removeAll()
            
            for result in results {
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self](image, error) in
                        if let image = image as? UIImage {
                            self?.photoList.append(image)
                            
                            DispatchQueue.main.async {
                                self?.collectionView.reloadData()
                            }
                        }
                    }
                } else {
                    print("사진을 불러오지 못했습니다.")
                }
            }
        }
    }
}
