//
//  AddViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/27.
//

import UIKit
import PhotosUI

class AddViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let ingredientsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.sectionHeaderTopPadding = .zero
        tableView.showsVerticalScrollIndicator = false
//        ingredientsTableView.isScrollEnabled = false
        return tableView
    }()
    
    var table: Int = 1
    var photoList: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(950)
        }
        
        let photoButton = UIButton()
        contentView.addSubview(photoButton)
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
        
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(photoButton.snp.top)
            make.left.equalTo(photoButton.snp.right).offset(10)
            make.right.equalToSuperview()
            make.bottom.equalTo(photoButton.snp.bottom)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.cellId)
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "레시피 제목"
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(photoButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        let titleTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "레시피 제목을 입력해주세요."
            textField.toStyledTextField(textField)
            textField.addPadding(width: 16)
            return textField
        }()
        
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        let priceLabel: UILabel = {
            let label = UILabel()
            label.text = "예상가격"
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        let priceTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "예상가격을 입력해주세요."
            textField.toStyledTextField(textField)
            textField.addPadding(width: 16)
            return textField
        }()
        
        contentView.addSubview(priceTextField)
        priceTextField.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        let participantLabel: UILabel = {
            let label = UILabel()
            label.text = "파티원"
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        contentView.addSubview(participantLabel)
        participantLabel.snp.makeConstraints { make in
            make.top.equalTo(priceTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        let participantTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "모집할 인원수를 입력해주세요."
            textField.toStyledTextField(textField)
            textField.addPadding(width: 16)
            return textField
        }()
        
        contentView.addSubview(participantTextField)
        participantTextField.snp.makeConstraints { make in
            make.top.equalTo(participantLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        let pricePerPersonLabel: UILabel = {
            let label = UILabel()
            label.text = "1인당 예상가격"
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        contentView.addSubview(pricePerPersonLabel)
        pricePerPersonLabel.snp.makeConstraints { make in
            make.top.equalTo(participantTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        let pricePerPersonDetailLabel: UILabel = {
            let label = UILabel()
            label.text = "*예상가격과 파티원 입력 시 자동계산 됩니다."
            label.textColor = .gray
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        
        contentView.addSubview(pricePerPersonDetailLabel)
        pricePerPersonDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(pricePerPersonLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(15)
        }
        
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        ingredientsTableView.register(IngredientsCell.self, forCellReuseIdentifier: IngredientsCell.cellID)
        
        contentView.addSubview(ingredientsTableView)
        ingredientsTableView.snp.makeConstraints { make in
            make.top.equalTo(pricePerPersonDetailLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo((table + 1) * 44)
        }
        
        let addButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .systemGray6
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.systemGray3.cgColor
            button.layer.cornerRadius = 10
            button.tintColor = .black
            return button
        }()
        
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(ingredientsTableView.snp.bottom)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let detailLabel: UILabel = {
            let label = UILabel()
            label.text = "상세설명"
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        let detailTextView: UITextView = {
            let textView = UITextView()
            textView.text = "상세내용을 작성해주세요."
            textView.font = .systemFont(ofSize: 16)
            textView.textColor = .systemGray3
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor.systemGray4.cgColor
            textView.layer.cornerRadius = 10
            return textView
        }()
        
        contentView.addSubview(detailTextView)
        detailTextView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(140)
        }
        
        let informationLabel: UILabel = {
            let label = UILabel()
            label.text = "우리 서비스는 제로웨이스트를 지향하고 있습니다.\n소분을 위한 용기를 미리 준비해주세요."
            label.numberOfLines = 2
            label.textColor = .systemGray3
            label.setLineSpacing(spacing: 10)
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 16)
            return label
        }()
        
        contentView.addSubview(informationLabel)
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(detailTextView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
        }
        
        let doneButton: UIButton = {
            let button = UIButton()
            button.setTitle("작성완료", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            button.backgroundColor = .primaryColor
            button.layer.cornerRadius = 10
            return button
        }()
        
        contentView.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        table += 1
        ingredientsTableView.insertRows(at: [IndexPath(row: table - 1, section: 0)], with: .bottom)
        ingredientsTableView.reloadRows(at: [IndexPath(row: table - 1, section: 0)], with: .bottom)
    }
    
    @objc private func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension AddViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellId, for: indexPath) as! PhotoCell
        cell.imageView.image = photoList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.cellID, for: indexPath) as! IngredientsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "재료명"
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .bodyColor
        titleLabel.textAlignment = .center
        let buyLabel = UILabel()
        buyLabel.text = "구매수량"
        buyLabel.font = .systemFont(ofSize: 14)
        buyLabel.textColor = .bodyColor
        buyLabel.textAlignment = .center
        let needLabel = UILabel()
        needLabel.text = "필요수량"
        needLabel.font = .systemFont(ofSize: 14)
        needLabel.textColor = .bodyColor
        needLabel.textAlignment = .center
        let shareLabel = UILabel()
        shareLabel.text = "나눔수량"
        shareLabel.font = .systemFont(ofSize: 14)
        shareLabel.textColor = .bodyColor
        shareLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, buyLabel, needLabel, shareLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        headerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension AddViewController: PHPickerViewControllerDelegate {
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
                    
                }
            }
        }
    }
}
