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
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray6
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.cornerRadius = 10
        button.tintColor = .black
        button.isEnabled = false
        return button
    }()
    
    let titleView = TitleView()
    
    var photoList: [UIImage] = []
    var table: Int = 0
    var navigation: UINavigationController?
    var recipe: [String: Any] = [:]
    var recipeIngredient: [String: Any] = [:]
    var recipeIngredients: [[String: Any]] = []
    var currentRow: Int = 0
    
    var ingredientName: String = ""
    var totalQty: Double = 0.0
    var requiredQty: Double = 0.0
    var sharingAvailableQty: Double = 0.0
    
    var recipeInfo: Board?
    var imageData: [Data] = []
    
    var putRecipe: Bool = false
    var putRecipeInfo: PostDto?
    
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
        keyboardNotification()
        
        print(putRecipeInfo)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }
    
    private func keyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.height
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardTopY, right: 0)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        tableView.contentInset = .zero
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
        tableView.register(IngredientListCell.self, forCellReuseIdentifier: IngredientListCell.cellId)
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
        if sender.isEnabled {
            self.recipeIngredient.removeAll()
            table += 1
            tableView.insertRows(at: [IndexPath(row: table - 1, section: 5)], with: .none)
            tableView.reloadRows(at: [IndexPath(row: table - 1, section: 5)], with: .none)
            tableView.reloadRows(at: [IndexPath(row: table + 1, section: 6)], with: .none) // 수정해야할 사항 - 열 추가하고 나면 필드 초기화
            sender.isEnabled.toggle()
        }
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        
        if self.putRecipe == false {
            guard let filename = recipe["title"] as? String else { return }
            let memberId: Int = UserDefaults.standard.integer(forKey: "UserId")
            var imageDatas: [Data] = []
            if self.imageData.isEmpty {
                guard let image = UIImage(named: "boardDefaultImage") else { return }
                guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
                imageDatas.append(imageData)
            } else {
                imageDatas = self.imageData
            }
            
            Network.shared.postRecipe(images: imageDatas, filename: filename, memberId: memberId, recipe: self.recipe, recipeIngredients: self.recipeIngredients, completion: { result in
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        let detail = UIStoryboard.init(name: "Detail", bundle: nil)
                        guard let viewController = detail.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
                            return
                        }
                        viewController.recipe = result
                        viewController.hidesBottomBarWhenPushed = true
                        self.navigation?.navigationItem.backButtonDisplayMode = .minimal
                        self.navigation?.pushViewController(viewController, animated: false)
                    }
                }
            })
        }
        if self.putRecipe {
            guard let putRecipeInfo = putRecipeInfo else { return }

            if self.recipe["title"] == nil {
                self.recipe.updateValue(putRecipeInfo.postDto.title, forKey: "title")
            }
            if self.recipe["recipeName"] == nil {
                self.recipe.updateValue(putRecipeInfo.postDto.recipeCalorie?.recipeName ?? "recipe", forKey: "recipeName")
            }
            if self.recipe["expectingPrice"] == nil {
                self.recipe.updateValue(putRecipeInfo.postDto.expectingPrice, forKey: "expectingPrice")
            }
            if self.recipe["peopleCount"] == nil {
                self.recipe.updateValue(putRecipeInfo.postDto.peopleCount, forKey: "peopleCount")
            }
            if self.recipe["pricePerOne"] == nil {
                self.recipe.updateValue(putRecipeInfo.postDto.pricePerOne, forKey: "pricePerOne")
            }
            if self.recipe["content"] == nil {
                self.recipe.updateValue(putRecipeInfo.postDto.content, forKey: "content")
            }
            guard let filename = recipe["title"] as? String else { return }
            let memberId: Int = UserDefaults.standard.integer(forKey: "UserId")
            var imageDatas: [Data] = []
            if self.imageData.isEmpty {
                guard let image = UIImage(named: "boardDefaultImage") else { return }
                guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
                imageDatas.append(imageData)
            } else {
                imageDatas = self.imageData
            }
            
            Network.shared.putRecipe(postId: putRecipeInfo.postDto.id, images: imageDatas, filename: filename, memberId: memberId, recipe: self.recipe, recipeIngredients: self.recipeIngredients) { result in
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        let detail = UIStoryboard.init(name: "Detail", bundle: nil)
                        guard let viewController = detail.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
                            return
                        }
                        viewController.recipe = result
                        //                        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: .none)
                        viewController.hidesBottomBarWhenPushed = true
                        self.navigation?.navigationItem.backButtonDisplayMode = .minimal
                        self.navigation?.pushViewController(viewController, animated: false)
                        
                    }
                }
            }
        }
    }
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension AddRecipeViewController: PHPickerViewControllerDelegate {
    @objc private func photoButtonTapped(_ sender: UIButton) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        if !(results.isEmpty) {
            photoList.removeAll()
            imageData.removeAll()
            
            for result in results {
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                        if let image = image as? UIImage {
                            self?.photoList.append(image)
                            guard let imageDatas = image.jpegData(compressionQuality: 0.7) else { return }
                            self?.imageData.append(imageDatas)
                            
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
