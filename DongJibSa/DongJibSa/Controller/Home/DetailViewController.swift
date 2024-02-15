//
//  DetailViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/28.
//

import UIKit
import FirebaseDatabase

class DetailViewController: UIViewController {
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    internal let profileHeaderView = ProfileHeaderView()
    internal let ingredientHeaderView = IngredientHeaderView()
    internal let commentHeaderView = CommentHeaderView()
    internal let commentTextFieldHeaderView = CommentTextFieldHeaderView()
    
    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .primaryColor
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "boardDefaultImage")
        return imageView
    }()
    
    private var maxTopHeight: CGFloat = 375
    private lazy var minTopHeight: CGFloat = 44 + (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height)!
    
    var recipe: PostDto?
    var recipeId: Int?
    var commentCount: Int = 0
    var comment: [[String: String]] = []
    
    var writer: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setNavigationBar()
        keyboardNotification()
        getRecipeAndComments()
    }
    
    private func keyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification:Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.height
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            _ = (textBoxY - keyboardTopY / 2)
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardTopY, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(_ notification:Notification) {
        tableView.contentInset = .zero
    }
    
    @objc func commentAddButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if commentTextFieldHeaderView.commentTextField.text == "" {
            
        } else {
            guard let user = UserDefaults.standard.dictionary(forKey: "User"),
                  let userName = user["nickName"] as? String else { return }
            guard let recipeId = recipeId else { return }
            let createdAt = Date().dateLongFormat
            let commentId = UUID().uuidString
            var ref: DatabaseReference
            ref = Database.database().reference()
            ref.child("\(recipeId)").child(commentId).setValue(["userName": "\(userName)", "comment":"\(commentTextFieldHeaderView.commentTextField.text!)", "createdAt": "\(createdAt)"])
            
            commentCount += 1
            comment.append(["userName": "\(userName)", "comment":"\(commentTextFieldHeaderView.commentTextField.text!)", "createdAt": "\(createdAt)"])
            commentTextFieldHeaderView.commentTextField.text = ""
            self.tableView.reloadData()
        }
    }
    
    private func setNavigationBar() {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 23))
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setPreferredSymbolConfiguration(.init(pointSize: 20), forImageIn: .normal)
        backButton.tintColor = .bodyColor
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    @objc func updateAndDeleteButtonTapped(_ sender: UIButton) {
        let viewController = UpdateAndDeleteViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        guard let recipe = recipe else { return }
        viewController.postDto = recipe
        self.present(viewController, animated: true)
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        recipeView.backgroundColor = .white
        
        if recipe?.postDto.imgUrls?[0] != nil {
            let imageURL = recipe?.postDto.imgUrls?[0] ?? ""
            recipeImageView.setImageURL(imageURL)
        } 
        
        recipeView.addSubview(recipeImageView)
        recipeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = .zero
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.cellId)
        tableView.register(IngredientsInfoCell.self, forCellReuseIdentifier: IngredientsInfoCell.cellId)
        tableView.register(RecipeTitleCell.self, forCellReuseIdentifier: RecipeTitleCell.cellId)
        tableView.register(RecipeContentCell.self, forCellReuseIdentifier: RecipeContentCell.cellId)
        tableView.register(RecipeInfoCell.self, forCellReuseIdentifier: RecipeInfoCell.cellId)
        tableView.register(CalorieCell.self, forCellReuseIdentifier: CalorieCell.cellId)
        tableView.register(EmptyCell.self, forCellReuseIdentifier: EmptyCell.cellId)
        tableView.register(CollectionCommentCell.self, forCellReuseIdentifier: CollectionCommentCell.cellId)
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getRecipeAndComments() {
        guard let recipeId = self.recipeId else { return }
        
        Network.shared.getRecipe(recipeId: recipeId) { result in
            self.recipe = result
            DispatchQueue.main.sync {
                self.tableView.reloadData()
                
                if self.recipe?.postDto.imgUrls?[0] != nil {
                    let imageURL = self.recipe?.postDto.imgUrls?[0] ?? ""
                    self.recipeImageView.setImageURL(imageURL)
                }
            }
        }
        
        // MARK: 파이어베이스 데이터베이스에서 댓글 읽어오기
        var ref: DatabaseReference
        ref = Database.database().reference()
        ref.child("\(recipeId)").getData(completion: { error, snapshot in
            guard let snapshot = snapshot else { return }
            guard let comment = snapshot.value as? [String: Any] else { return }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: Array(comment.values), options: [])
                let decoder = JSONDecoder()
                var comments = try decoder.decode([[String: String]].self, from: data)
                comments.sort { $0["createdAt"]! < $1["createdAt"]! }
                for item in comments {
                    self.comment.append(item)
                }
                self.commentCount = comment.count 
                self.tableView.reloadData()
                
            } catch {
                
            }
        })
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ tableView: UIScrollView) {
        let y: CGFloat = tableView.contentOffset.y
        let modifiedTopHeight: CGFloat = recipeViewHeight.constant - y
        if (modifiedTopHeight > maxTopHeight) {
            recipeViewHeight.constant = maxTopHeight
        } else if (modifiedTopHeight < minTopHeight) {
            recipeViewHeight.constant = minTopHeight
        } else {
            recipeViewHeight.constant = modifiedTopHeight
            tableView.contentOffset.y = 0
        }
    }
}

