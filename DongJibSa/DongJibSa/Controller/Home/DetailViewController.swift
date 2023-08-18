//
//  DetailViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/28.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var maxTopHeight: CGFloat = 375
    lazy var minTopHeight: CGFloat = 44 + (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height)!
    
    var table: Int = 3
    var recipeInfo: Board?
    var commentCount: Int = 0
    var comment: String = ""
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.toStyledTextField(textField)
        textField.placeholder = "댓글을 입력하세요..."
        textField.addPadding(width: 10)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        keyboardNotification()
        commentTextField.delegate = self
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
    
    @objc func addButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.commentTextField.text == "" {
            
        } else {
            self.commentTextField.text = ""
            commentCount += 1
            self.tableView.insertRows(at: [IndexPath(row: commentCount - 1, section: 2)], with: .middle)
            self.tableView.reloadData()
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        recipeView.backgroundColor = .white
        
        let recipeImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .primaryColor
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            return imageView
        }()
        let imageURL = recipeInfo?.imgUrl ?? ""
        recipeImageView.setImageURL(imageURL)
        
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
        tableView.register(RecipeInfoCell.self, forCellReuseIdentifier: RecipeInfoCell.cellId)
        tableView.register(EmptyCell.self, forCellReuseIdentifier: EmptyCell.cellId)
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
        self.comment = textField.text ?? ""
    }
}
