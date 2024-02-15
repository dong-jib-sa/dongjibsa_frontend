//
//  UpdateAndDeleteViewController.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/02.
//

import UIKit

final class UpdateAndDeleteViewController: UIViewController {
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let updateButton: UIButton = {
        var attString = AttributedString("게시글 수정하기")
        attString.font = .systemFont(ofSize: 16)
        attString.foregroundColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
        configuration.imagePadding = 16
        configuration.baseForegroundColor = .black
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .primaryColor
        button.contentHorizontalAlignment = .leading
        button.isSelected = false
        return button
    }()
    
    private let deleteButton: UIButton = {
        var attString = AttributedString("게시글 삭제하기")
        attString.font = .systemFont(ofSize: 16)
        attString.foregroundColor = .black
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
        configuration.imagePadding = 16
        configuration.baseForegroundColor = .black
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .primaryColor
        button.contentHorizontalAlignment = .leading
        button.isSelected = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [updateButton, deleteButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    var postDto: PostDto?
    
    let dismissUpdateAndDeleteView: Notification.Name = Notification.Name("DismissUpdateAndDeleteView")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.post(name: dismissUpdateAndDeleteView, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // MEMO: 배경 터치시 현재 뷰 컨트롤러 내리기
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true)
        }
    }
    
    func setupView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(160)
        }
        mainView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func updateButtonTapped(_ sender: UIButton) {
        print("게시글 수정")
        guard let postDto = postDto else { return }
        let recipt = postDto.postDto
        
//        self.dismiss(animated: true) {
            
            let addViewController = AddRecipeViewController(navigationController: self.navigationController)
            
            let navigationController = UINavigationController(rootViewController: addViewController)
            navigationController.modalPresentationStyle = .fullScreen
            addViewController.navigationItem.title = NSLocalizedString("레시피 파티원 모집하기", comment: "")
            addViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(self.closeAddViewController))
            // image URL -> UIImage
            addViewController.putRecipe = true
            let imageURL = recipt.imgUrls
            addViewController.photoList = self.setImageView(with: imageURL ?? [])
            addViewController.table = recipt.recipeIngredients.count
            addViewController.putRecipeInfo = postDto
            var recipeIngredients: [[String: Any]] = []
            var recipeIngredient: [String: Any] = [:]
            for i in 0..<recipt.recipeIngredients.count {
                recipeIngredient["ingredientName"] = recipt.recipeIngredients[i].ingredientName
                recipeIngredient["totalQty"] = Int(ceil(recipt.recipeIngredients[i].totalQty))
                recipeIngredient["requiredQty"] = Int(ceil(recipt.recipeIngredients[i].requiredQty))
                recipeIngredient["sharingAvailableQty"] = Int(ceil(recipt.recipeIngredients[i].sharingAvailableQty))
                recipeIngredients.append(recipeIngredient)
                recipeIngredient.removeAll()
            }
            addViewController.recipeIngredients = recipeIngredients
            
            navigationController.navigationBar.tintColor = .bodyColor
            self.present(navigationController, animated: true)
//        }
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        print("게시글 삭제")
        
        // MARK: 삭제 알럿
        let alert = UIAlertController(title: "게시글을 정말 삭제 하시겠어요?", message: "삭제한 게시글은 복구되지 않습니다.", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "취소", style: .default)
        let deleteAction = UIAlertAction(title: "삭제하기", style: .default) { _ in
            guard let postId = self.postDto?.postDto.id else { return }
            Network.shared.deleteMyRecipe(postId: postId)
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: self.dismissUpdateAndDeleteView, object: nil)
            }
        }
        alert.addAction(doneAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
        // ["result": "9번 게시글이 삭제되었습니다.", "resultCode": "SUCCESS!"]
    }
    
    @objc func closeAddViewController() {
        self.dismiss(animated: true)
    }
}

extension UpdateAndDeleteViewController {
    func setImageView(with urlStrs: [String]) -> [UIImage] {
        var imageList: [UIImage] = []
        for urlStr in urlStrs {
            guard let url = URL(string: urlStr) else { return [] }
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data, let _ = error else { return }
//                if let image = UIImage(data: data) {
//                    imageList.append(image)
//                }
//            }.resume()
            do {
                guard let data = try? Data(contentsOf: url) else { return [] }
                guard let image = UIImage(data: data) else { return [] }
                imageList.append(image)
            } catch {
                print("이미지를 불러올 수 없습니다.")
            }
        }
        return imageList
    }
}
