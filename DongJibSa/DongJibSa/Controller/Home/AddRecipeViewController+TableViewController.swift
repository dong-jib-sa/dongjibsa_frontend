//
//  AddRecipeViewController+TableViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/31.
//

import UIKit

extension AddRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return table
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.cellId, for: indexPath) as! TextFieldCell
            cell.textField.placeholder = "예상가격을 입력해주세요."
            cell.textField.keyboardType = .numberPad
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.cellId, for: indexPath) as! TextFieldCell
            cell.textField.placeholder = "모집할 인원수를 입력해주세요."
            cell.textField.keyboardType = .numberPad
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.cellId, for: indexPath) as! TextFieldCell
            cell.textField.placeholder = "*예상가격과 파티원 입력 시 자동계산 됩니다."
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.cellID, for: indexPath) as! IngredientsCell
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.cellId, for: indexPath) as! EmptyCell
            cell.selectionStyle = .none
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTextViewCell.cellId, for: indexPath) as! DetailTextViewCell
            cell.selectionStyle = .none
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: DoneButtonCell.cellId, for: indexPath) as! DoneButtonCell
            cell.selectionStyle = .none
            cell.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.cellId, for: indexPath) as! TextFieldCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return 44
        } else if indexPath.section == 6 {
            return 160
        } else if indexPath.section == 5 {
            return 0
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        switch section {
        case 0:
            let pricePerPersonLabel: UILabel = {
                let label = UILabel()
                label.text = "레시피 제목"
                label.font = .systemFont(ofSize: 16)
                label.textColor = .bodyColor
                return label
            }()
            
            headerView.addSubview(pricePerPersonLabel)
            pricePerPersonLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(4)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(20)
            }
            return headerView
        case 1:
            let pricePerPersonLabel: UILabel = {
                let label = UILabel()
                label.text = "예상가격"
                label.font = .systemFont(ofSize: 16)
                label.textColor = .bodyColor
                return label
            }()
            
            headerView.addSubview(pricePerPersonLabel)
            pricePerPersonLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(4)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(20)
            }
            return headerView
        case 2:
            let pricePerPersonLabel: UILabel = {
                let label = UILabel()
                label.text = "파티원"
                label.font = .systemFont(ofSize: 16)
                label.textColor = .bodyColor
                return label
            }()
            
            headerView.addSubview(pricePerPersonLabel)
            pricePerPersonLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(4)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(20)
            }
            return headerView
        case 3:
            let pricePerPersonLabel: UILabel = {
                let label = UILabel()
                label.text = "1인당 예상가격"
                label.font = .systemFont(ofSize: 16)
                label.textColor = .bodyColor
                return label
            }()
            
            headerView.addSubview(pricePerPersonLabel)
            pricePerPersonLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(4)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(20)
            }
            return headerView
        case 4:
            let titleLabel = UILabel()
            titleLabel.text = "재료명"
            titleLabel.font = .systemFont(ofSize: 16)
            titleLabel.textColor = .bodyColor
            titleLabel.textAlignment = .center
            let buyLabel = UILabel()
            buyLabel.text = "구매수량"
            buyLabel.font = .systemFont(ofSize: 16)
            buyLabel.textColor = .bodyColor
            buyLabel.textAlignment = .center
            let needLabel = UILabel()
            needLabel.text = "필요수량"
            needLabel.font = .systemFont(ofSize: 16)
            needLabel.textColor = .bodyColor
            needLabel.textAlignment = .center
            let shareLabel = UILabel()
            shareLabel.text = "나눔수량"
            shareLabel.font = .systemFont(ofSize: 16)
            shareLabel.textColor = .bodyColor
            shareLabel.textAlignment = .center
            
            let stackView = UIStackView(arrangedSubviews: [titleLabel, buyLabel, needLabel, shareLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            
            headerView.addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.right.equalToSuperview().inset(16)
            }
            
            return headerView
        case 5:
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
            
            headerView.addSubview(addButton)
            addButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
            addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            
            return headerView
        case 6:
            let pricePerPersonLabel: UILabel = {
                let label = UILabel()
                label.text = "상세내용"
                label.font = .systemFont(ofSize: 16)
                label.textColor = .bodyColor
                return label
            }()
            
            headerView.addSubview(pricePerPersonLabel)
            pricePerPersonLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(4)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(20)
            }
            return headerView
        default:
            let pricePerPersonLabel: UILabel = {
                let label = UILabel()
                label.text = "우리 서비스는 제로웨이스트를 지향하고 있습니다.\n소분을 위한 용기를 미리 준비해주세요."
                label.numberOfLines = 2
                label.textColor = .systemGray3
                label.setLineSpacing(spacing: 10)
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 16)
                return label
            }()
            
            headerView.addSubview(pricePerPersonLabel)
            pricePerPersonLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.right.equalToSuperview().inset(16)
            }
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 4:
            return 40
        case 5:
            return 60
        case 7:
            return 100
        default:
            return 30
        }
    }
}
