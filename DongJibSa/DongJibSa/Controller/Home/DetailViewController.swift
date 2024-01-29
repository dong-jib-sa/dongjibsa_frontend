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
    
    var maxTopHeight: CGFloat = 375
    lazy var minTopHeight: CGFloat = 44 + (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height)!
    
    var table: Int = 3
    var recipe: PostDto? 
//    {
//        didSet {
////            onChange(recipe)
//        }
//    }
//    var onChange: (PostDto) -> Void
    var commentCount: Int = 0
    var comment: [[String: String]] = []
    var recipeId: Int?
    
    var writer: Bool = false
    
//    init(recipeView: UIView!, recipeViewHeight: NSLayoutConstraint!, tableView: UITableView!, maxTopHeight: CGFloat, table: Int, recipe: PostDto, onChange: @escaping (PostDto) -> Void, commentCount: Int, comment: [[String : String]], recipeId: Int? = nil, writer: Bool) {
//        self.recipeView = recipeView
//        self.recipeViewHeight = recipeViewHeight
//        self.tableView = tableView
//        self.maxTopHeight = maxTopHeight
//        self.table = table
//        self.recipe = recipe
//        self.onChange = onChange
//        self.commentCount = commentCount
//        self.comment = comment
//        self.recipeId = recipeId
//        self.writer = writer
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setNavigationBar()
        keyboardNotification()
        commentTextFieldHeaderView.commentTextField.delegate = self
        getdateNetwork()
    }
    
    private func keyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.height
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2)
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardTopY, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        tableView.contentInset = .zero
    }
    
    @objc func commentAddButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if commentTextFieldHeaderView.commentTextField.text == "" {
            
        } else {
            let memberId = "\(UserDefaults.standard.integer(forKey: "UserId"))"
            guard let recipeId = recipeId as? Int else { return }
            let userName = UserDefaults.standard.string(forKey: "UserNickName")
            let createdAt = Date().dateLongFormat
            let commentId = UUID().uuidString
            var ref: DatabaseReference
            ref = Database.database().reference()
            ref.child("\(recipeId)").child(commentId).setValue(["userName": "\(userName!)", "comment":"\(commentTextFieldHeaderView.commentTextField.text!)", "createdAt": "\(createdAt)"])
            
            commentCount += 1
            comment.append(["userName": "\(userName!)", "comment":"\(commentTextFieldHeaderView.commentTextField.text!)", "createdAt": "\(createdAt)"])
            commentTextFieldHeaderView.commentTextField.text = ""
//            self.tableView.insertRows(at: [IndexPath(row: commentCount - 1, section: 4)], with: .middle)
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
        
//        if writer {
//            let updateAndDeleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 23))
//            updateAndDeleteButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
//            updateAndDeleteButton.setPreferredSymbolConfiguration(.init(pointSize: 20), forImageIn: .normal)
//            updateAndDeleteButton.tintColor = .bodyColor
//            updateAndDeleteButton.addTarget(self, action: #selector(updateAndDeleteButtonTapped), for: .touchUpInside)
//            let updateAndDeleteItem = UIBarButtonItem(customView: updateAndDeleteButton)
//            self.navigationItem.rightBarButtonItem = updateAndDeleteItem
//            
//        }
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
        
//        let recipeImageView: UIImageView = {
//            let imageView = UIImageView()
//            imageView.backgroundColor = .primaryColor
//            imageView.contentMode = .scaleAspectFill
//            imageView.layer.masksToBounds = true
//            imageView.image = UIImage(named: "boardDefaultImage")
//            return imageView
//        }()
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
        
//        let keyboardView = UIView()
//        keyboardView.backgroundColor = .green
//        self.view.addSubview(keyboardView)
//        keyboardView.snp.makeConstraints { make in
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(80)
//        }
//        getdateNetwork()
        
        
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getdateNetwork() {
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
        
        // MARK: 댓글 파이어베이스 데이터베이스에서 읽어오기
        var ref: DatabaseReference
        ref = Database.database().reference()
        guard let recipeId = recipeId as? Int else { return }
        ref.child("\(recipeId)").getData(completion: { error, snapshot in
            guard let snapshot = snapshot else { return }
            guard let comment = snapshot.value as? [String: Any] else { return }
            print(comment)
            do {
                let data = try JSONSerialization.data(withJSONObject: Array(comment.values), options: [])
                let decoder = JSONDecoder()
                let comments = try decoder.decode([[String: String]].self, from: data)
                for item in comments {
                    self.comment.append(item)
                }
                self.commentCount = comment.count ?? 0
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

extension DetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // MARK: 댓글은 파이어베이스 연동 -> 맨 나중에
//        let userName: String = UserDefaults.standard.string(forKey: "UserNickName")!
//        self.comment.append(["\(userName)\(commentCount)":"\(commentTextFieldHeaderView.commentTextField.text)"])
    }
}

//extension DetailViewController: ButtonTappedDelegate {
//    func cellButtonTapped(for cell: CommentCell) {
//        guard let indexPath = cell.indexPath else { return }
//        let section = indexPath.section
//        let row = indexPath.row
//        commentTextFieldHeaderView.commentTextField.becomeFirstResponder()
//        self.tableView.insertRows(at: [IndexPath(row: row, section: section)], with: .middle)
//        self.tableView.reloadData()
//    }
//}
