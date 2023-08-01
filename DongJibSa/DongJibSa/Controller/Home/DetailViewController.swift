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
        viewTappedKeyboardCancel()
    }
    
    private func viewTappedKeyboardCancel() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc func addButtonTapped(_ sender: UIButton) {
        // textField가 비어있을때는 추가되지 않도록
        // 텍스트필드가 올라왔을때 전송 버튼이 눌러지지 않는 현상
        // -> 테이블뷰의 스크롤이 위로 올라가도록 구현하는게 나을 것 같음
        if commentTextField.text == "" {
            
        } else {
            table += 1
            tableView.insertRows(at: [IndexPath(row: table - 1, section: 2)], with: .bottom)
            tableView.reloadRows(at: [IndexPath(row: table - 1, section: 2)], with: .bottom)
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        let recipeImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .primaryColor
            return imageView
        }()
        
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
