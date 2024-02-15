//
//  CollectionCommentCell.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/25.
//

import UIKit

class CollectionCommentCell: UITableViewCell {
    static let cellId: String = "CollectionCommentCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "저요~!! 오늘 저녁 뭐 먹나 했는데, 메뉴 나왔네요!"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
//    lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = .init(width: self.collectionView.frame.width, height: 100)
//        return layout
//    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.contentInset = .zero
        collectionView.register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: CommentCollectionViewCell.cellId)
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return collectionView
    }()
    
    var items: [[String: String]] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell()
        
        self.contentView.addSubview(cellView)
        cellView.addSubview(collectionView)
        
        cellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
//        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CollectionCommentCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCollectionViewCell.cellId, for: indexPath) as! CommentCollectionViewCell
        cell.userNameLabel.text = self.items[indexPath.item]["userName"]
        cell.commentLabel.text = self.items[indexPath.item]["comment"]
        if let dateTime = self.items[indexPath.item]["createdAt"]!.dateLong as? Date {
            cell.timeLabel.text = dateTime.dayAndTimeText            
        }
//        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 100
        return CGSize(width: width, height: height)
    }
}

//extension CollectionCommentCell: ButtonTappedDelegate {
//    func cellButtonTapped(for cell: CommentCell) {
//        
//    }
//    
//    
//    func cellButtonTapped() {
//        print("버튼 눌렀다")
//        let commentTextFieldHeaderView = CommentTextFieldHeaderView()
//        commentTextFieldHeaderView.commentTextField.becomeFirstResponder()
//    }
//}
