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
    
    let scrollView = UIScrollView()
    var maxTopHeight: CGFloat = 375
    lazy var minTopHeight: CGFloat = 44 + (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height)!
    
    let ingredientsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.sectionHeaderTopPadding = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorInset = .zero
        return tableView
    }()
    
    let commentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.sectionHeaderTopPadding = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .zero
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var table: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
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
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(recipeView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        scrollView.delegate = self
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1000)
        }
        
        let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .primaryColor
            imageView.layer.cornerRadius = 45 / 2
            return imageView
        }()
        
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(45)
        }
        
        let userNameLabel: UILabel = {
            let label = UILabel()
            label.text = "집밥이지"
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        
        let locationLabel: UILabel = {
            let label = UILabel()
            label.text = "신대방동"
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        let profileStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [userNameLabel, locationLabel])
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            return stackView
        }()
        
        contentView.addSubview(profileStackView)
        profileStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(16)
        }
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "새우 부추전 파티원 모집합니다."
            label.font = .boldSystemFont(ofSize: 19)
            return label
        }()
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileStackView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        let writeDateLabel: UILabel = {
            let label = UILabel()
            label.text = "2023.07.28."
            label.font = .systemFont(ofSize: 14)
            label.textAlignment = .left
            label.textColor = .gray
            return label
        }()
        
        let timeLabel: UILabel = {
            let label = UILabel()
            label.text = "1시간 전"
            label.font = .systemFont(ofSize: 14)
            label.textAlignment = .right
            label.textColor = .gray
            return label
        }()
        
        let timeLineStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [writeDateLabel, timeLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            return stackView
        }()
        
        contentView.addSubview(timeLineStackView)
        timeLineStackView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        let detailLabel: UILabel = {
            let label = UILabel()
            label.text = "양배추랑 돼지고기가 많이 남는데 필요하신 분 있나요? 재료 나눔합니다~"
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLineStackView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
        }
        
        let recipeInfoLabel: UILabel = {
            let label = UILabel()
            label.text = "레시피 정보"
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        let priceLabel: UILabel = {
            let label = UILabel()
            label.text = "예상가: 25,000원"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .gray
            return label
        }()
        
        let participantLabel: UILabel = {
            let label = UILabel()
            label.text = "파티원: 4명"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .gray
            return label
        }()
        
        let pricePerPersonLabel: UILabel = {
            let label = UILabel()
            label.text = "1인당 예상 구매가: 6500원"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .gray
            return label
        }()
        
        let descriptionStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [recipeInfoLabel, priceLabel, participantLabel, pricePerPersonLabel])
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            return stackView
        }()
        
        contentView.addSubview(descriptionStackView)
        descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        
        
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        ingredientsTableView.register(IngredientsInfoCell.self, forCellReuseIdentifier: IngredientsInfoCell.cellID)
        
        contentView.addSubview(ingredientsTableView)
        ingredientsTableView.snp.makeConstraints { make in
            make.top.equalTo(descriptionStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo((table + 1) * 44)
        }
        
        let likeImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "heart.fill")
            imageView.tintColor = .gray
            return imageView
        }()
        
        let likeLabel: UILabel = {
            let label = UILabel()
            label.text = "7"
            label.textColor = .gray
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        let likeStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [likeImageView, likeLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 8
            return stackView
        }()
        
        let talkImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "message")
            imageView.tintColor = .gray
            return imageView
        }()
        
        let talkLabel: UILabel = {
            let label = UILabel()
            label.text = "3"
            label.textColor = .gray
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        let talkStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [talkImageView, talkLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 8
            return stackView
        }()
        
        let viewImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "eye")
            imageView.tintColor = .gray
            return imageView
        }()
        
        let viewLabel: UILabel = {
            let label = UILabel()
            label.text = "24"
            label.textColor = .gray
            label.font = .systemFont(ofSize: 12)
            return label
        }()
        
        let viewStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [viewImageView, viewLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 8
            return stackView
        }()
        
        let emptyView: UIView = {
            let view = UIView()
            return view
        }()
        
        let listStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [likeStackView, talkStackView, emptyView, viewStackView])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 20
            return stackView
        }()
        
        contentView.addSubview(listStackView)
        listStackView.snp.makeConstraints { make in
            make.top.equalTo(ingredientsTableView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
        }
        
        let seperateView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray3
            return view
        }()
        
        contentView.addSubview(seperateView)
        seperateView.snp.makeConstraints { make in
            make.top.equalTo(listStackView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        

        commentTableView.dataSource = self
        commentTableView.delegate = self
        commentTableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.cellId)

        contentView.addSubview(commentTableView)
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(seperateView.snp.bottom)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo((table + 1) * 100)
        }
        
        let footerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        contentView.addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(-34)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        let commentView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()

        footerView.addSubview(commentView)
        commentView.snp.makeConstraints { make in
            make.top.equalTo(footerView.snp.top)
            make.bottom.equalTo(footerView.snp.bottom).inset(34)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }

        let commentTextField: UITextField = {
            let textField = UITextField()
            textField.toStyledTextField(textField)
            textField.placeholder = "댓글을 입력하세요..."
            return textField
        }()

        commentTextField.snp.makeConstraints { make in
            make.height.equalTo(38)
        }

        let photoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "photo")
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .gray
            return imageView
        }()

        let sendButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "paperplane"), for: .normal)
            button.tintColor = .gray
            return button
        }()

        let commentStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [photoImageView, commentTextField, sendButton])
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.alignment = .center
            stackView.spacing = 10
            return stackView
        }()

        commentView.addSubview(commentStackView)
        commentStackView.snp.makeConstraints { make in
            make.bottom.equalTo(commentView.snp.bottom).inset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let modifiedTopHeight: CGFloat = recipeViewHeight.constant - y
        if (modifiedTopHeight > maxTopHeight) {
            recipeViewHeight.constant = maxTopHeight
        } else if (modifiedTopHeight < minTopHeight) {
            recipeViewHeight.constant = minTopHeight
        } else {
            recipeViewHeight.constant = modifiedTopHeight
            scrollView.contentOffset.y = 0
        }
    }
}
