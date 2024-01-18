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
    var recipe: [String: Any] = [:]
    var recipeIngredients: [[String: Any]] = []
    
    var ingredientName: String = ""
    var totalQty: Double = 0.0
    var requiredQty: Double = 0.0
    var sharingAvailableQty: Double = 0.0
    
    var recipeInfo: Board?
    var imageData: Data?
    
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
        if self.ingredientName == "" || self.totalQty == 0.0 || self.requiredQty == 0.0 || self.sharingAvailableQty == 0.0 {
            let alert = UIAlertController(title: "", message: "재료명, 구매수량, 필요수량, 나눔수량 중에서 빠진 것이 없는지 확인하세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        } else if self.totalQty != self.requiredQty + self.sharingAvailableQty {
            let alert = UIAlertController(title: "", message: "구매수량, 필요수량, 나눔수량을 잘 작성하였는지 확인하세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            self.recipeIngredients.append(["ingredientName": self.ingredientName, "totalQty": self.totalQty, "requiredQty": self.requiredQty, "sharingAvailableQty": self.sharingAvailableQty])
            self.ingredientName = ""
            self.totalQty = 0.0
            self.requiredQty = 0.0
            self.sharingAvailableQty = 0.0
            
            table += 1
            tableView.insertRows(at: [IndexPath(row: table - 1, section: 5)], with: .bottom)
            tableView.reloadRows(at: [IndexPath(row: table - 1, section: 5)], with: .bottom)
        }
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        guard let imageData = self.imageData else { return }
        guard let filename = recipe["title"] as? String else { return }
        
        Network.shared.postBoard(image: imageData, filename: filename, recipe: self.recipe, recipeIngredients: self.recipeIngredients, completion: { arr in
            print("테스트 성공?!")
            let imageUrl: String = arr[0]
            let createdAt: String = arr[1]
            let userName: String = "지예로운사람"
            
            let expectingPrice: String = "\(self.recipe["expectingPrice"] ?? "25000")"
            let peopleCount: String = "\(self.recipe["peopleCount"] ?? "4")"
            let pricePerOne = Int("\(Int(expectingPrice)! / Int(peopleCount)!)")
            var recipeIngredientsResult: [RecipeIngredients] = []
            
            for i in 0..<self.table {
                let recipeIngredient = RecipeIngredients(ingredientName: "\(self.recipeIngredients[i]["ingredientName"] ?? "두부")", totalQty: Double("\(self.recipeIngredients[i]["totalQty"] ?? 2.0)")!, requiredQty: Double("\(self.recipeIngredients[i]["requiredQty"] ?? 2.0)")!, sharingAvailableQty: Double("\(self.recipeIngredients[i]["sharingAvailableQty"] ?? 2.0)")!)
                recipeIngredientsResult.append(recipeIngredient)
            }
            
            let recipeInfo: Board = Board(title: "\(self.recipe["title"] ?? "제목")", content: "\(self.recipe["content"] ?? "알배추, 청경채, 깻잎, 소고기 목심, 팽이랑 표고버섯 구매할 건데 재료가 너무 많이 남을거 같아서요~ㅠ같이 공구하실 분 구합니다~!")", expectingPrice: Int("\(self.recipe["expectingPrice"] ?? 0)")!, pricePerOne: pricePerOne!, peopleCount: Int("\(self.recipe["peopleCount"] ?? 4)")!, recipeIngredients: recipeIngredientsResult, imgUrl: "\(self.recipe["imgUrl"] ?? imageUrl)", createdAt: createdAt)
            
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                    let detail = UIStoryboard.init(name: "Detail", bundle: nil)
                    guard let viewController = detail.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
                        return
                    }
                    viewController.recipeInfo = recipeInfo
                    viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: .none)
                    viewController.hidesBottomBarWhenPushed = true
                    self.navigation?.navigationItem.backButtonDisplayMode = .minimal
                    self.navigation?.pushViewController(viewController, animated: false)
                }
            }
        })
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
                            self?.imageData = image.jpegData(compressionQuality: 0.7)
                            
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
