//
//  AddRecipeViewController+TableViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/31.
//

import UIKit

extension AddRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5 {
            return table
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.cellId, for: indexPath) as! TextFieldCell
            if self.putRecipe {
                guard let putRecipeInfo = putRecipeInfo else { return cell }
                cell.textField.text = putRecipeInfo.postDto.recipeCalorie?.recipeName
                
            } else {
                cell.textField.placeholder = "레시피 명을 입력해주세요. (예시: 낚지볶음)"
            }
            cell.textField.delegate = self
            cell.textField.tag = indexPath.section
            cell.textField.addTarget(self, action: #selector(limitedTextFieldDidChange), for: .editingChanged)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.cellId, for: indexPath) as! TextFieldCell
            if self.putRecipe {
                guard let putRecipeInfo = putRecipeInfo else { return cell }
                cell.textField.text = "\(putRecipeInfo.postDto.expectingPrice)"
                
            } else {
                cell.textField.placeholder = "예상가격을 입력해주세요."
            }
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            cell.textField.tag = indexPath.section
            cell.textField.addTarget(self, action: #selector(limitedTextFieldDidChange), for: .editingChanged)
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.cellId, for: indexPath) as! TextFieldCell
            if self.putRecipe {
                guard let putRecipeInfo = putRecipeInfo else { return cell }
                cell.textField.text = "\(putRecipeInfo.postDto.peopleCount)"
                
            } else {
                cell.textField.placeholder = "인원수는 최대 4명까지만 입력 가능해요."
            }
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            cell.textField.tag = indexPath.section
            cell.textField.addTarget(self, action: #selector(partyTextFieldDidChange), for: .editingChanged)
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.cellId, for: indexPath) as! TextFieldCell
            cell.textField.placeholder = "*예상가격과 파티원 입력 시 자동계산 됩니다."
            cell.textField.delegate = self
            cell.selectionStyle = .none
            cell.textField.tag = indexPath.section
            cell.textField.isEnabled = false
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientListCell.cellId, for: indexPath) as! IngredientListCell
            cell.titleLabel.text = "\(self.recipeIngredients[indexPath.row]["ingredientName"]!)"
            cell.buyLabel.text = "\(self.recipeIngredients[indexPath.row]["totalQty"]!)"
            cell.needLabel.text = "\(self.recipeIngredients[indexPath.row]["requiredQty"]!)"
            cell.shareLabel.text = "\(self.recipeIngredients[indexPath.row]["sharingAvailableQty"]!)"
            cell.selectionStyle = .none
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.cellID, for: indexPath) as! IngredientsCell
            if self.putRecipe {
//                cell.titleTextField.text = "\(self.recipeIngredients[indexPath.row]["ingredientName"] ?? "")"
//                cell.buyTextField.text = "\(self.recipeIngredients[indexPath.row]["totalQty"] ?? "")"
//                cell.needTextField.text = "\(self.recipeIngredients[indexPath.row]["requiredQty"] ?? "")"
//                cell.shareTextField.text = "\(self.recipeIngredients[indexPath.row]["sharingAvailableQty"] ?? "")"
            }
            cell.titleTextField.delegate = self
            cell.buyTextField.delegate = self
            cell.needTextField.delegate = self
            cell.shareTextField.delegate = self
            cell.titleTextField.tag = 5
            cell.buyTextField.tag = 6
            cell.needTextField.tag = 7
            cell.shareTextField.tag = 8
            cell.buyTextField.keyboardType = .numberPad
            cell.needTextField.keyboardType = .numberPad
            cell.shareTextField.keyboardType = .numberPad
            cell.titleTextField.addTarget(self, action: #selector(limitedTitleTextFieldDidChange), for: .editingChanged)
            cell.buyTextField.addTarget(self, action: #selector(QtyTextFieldDidChange), for: .editingChanged)
            cell.needTextField.addTarget(self, action: #selector(QtyTextFieldDidChange), for: .editingChanged)
            cell.shareTextField.addTarget(self, action: #selector(QtyTextFieldDidChange), for: .editingChanged)
            cell.selectionStyle = .none
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.cellId, for: indexPath) as! EmptyCell
            cell.selectionStyle = .none
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTextViewCell.cellId, for: indexPath) as! DetailTextViewCell
            cell.selectionStyle = .none
            cell.detailTextView.delegate = self
            if self.putRecipe {
                guard let putRecipeInfo = putRecipeInfo else { return cell }
                cell.detailTextView.text = "\(putRecipeInfo.postDto.content)"
            }
            return cell
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: DoneButtonCell.cellId, for: indexPath) as! DoneButtonCell
            cell.selectionStyle = .none
            cell.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
            if self.putRecipe {
                cell.doneButton.setTitle("수정완료", for: .normal)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.cellId, for: indexPath) as! TextFieldCell
            cell.textField.tag = indexPath.section
            cell.textField.delegate = self
            cell.textField.addTarget(self, action: #selector(limitedTextFieldDidChange), for: .editingChanged)
            cell.selectionStyle = .none
            if self.putRecipe {
                guard let putRecipeInfo = putRecipeInfo else { return cell }
                cell.textField.text = "\(putRecipeInfo.postDto.title)"
            }
            return cell
        }
    }
    
    @objc func limitedTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count < 100 {
            
        } else {
            textField.deleteBackward()
        }
    }
    
    @objc func limitedTitleTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count < 15 {
            
        } else {
            textField.deleteBackward()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 5 {
            return 44
        } else if indexPath.section == 6 {
            return 44
        } else if indexPath.section == 7 {
            return 0
        } else if indexPath.section == 8 {
            return 160
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        switch section {
        case 0:
            
            let pricePerPersonLabel: UILabel = {
                let label = UILabel()
                label.text = "게시글 제목"
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
                label.text = "레시피 명"
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
        case 3:
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
        case 4:
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
        case 5:
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
        case 7:
//            let addButton: UIButton = {
//                let button = UIButton()
//                button.backgroundColor = .systemGray6
//                button.setImage(UIImage(systemName: "plus"), for: .normal)
//                button.layer.borderWidth = 0.5
//                button.layer.borderColor = UIColor.systemGray3.cgColor
//                button.layer.cornerRadius = 10
//                button.tintColor = .black
//                button.isEnabled = false
//                return button
//            }()
            
            headerView.addSubview(addButton)
            addButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
            addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            
            return headerView
        case 8:
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
        case 9:
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
        default:
            return headerView
        }
    }
    
    @objc func partyTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count < 2 {
            // MARK: 최대 4명
        } else {
            textField.deleteBackward()
        }
    }
    
    @objc func QtyTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count <= 2 {
            
        } else {
            textField.deleteBackward()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 5:
            return 40
        case 6:
            return 8
        case 7:
            return 60
        case 9:
            return 100
        default:
            return 30
        }
    }
    
    // 재료 리스트에 관하여 스와이프하여 삭제하는 기능
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? IngredientListCell else {
            return .none
        }
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        self.recipeIngredients.remove(at: indexPath.row)
        self.table -= 1
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? IngredientListCell else {
            return
        }
        currentRow = indexPath.row
    }
}

extension AddRecipeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            self.recipe["title"] = textField.text ?? ""
        case 1:
            self.recipe["recipeName"] = textField.text ?? ""
        case 2:
            self.recipe["expectingPrice"] = Int(textField.text ?? "0") ?? 0
        case 3:
            self.recipe["peopleCount"] = Int(textField.text ?? "0") ?? 0
        case 4:
            if textField.text == nil {
                self.recipe["pricePerOne"] = "\(Int(self.recipe["expectingPrice"] as! String)! / Int(self.recipe["peopleCount"] as! String)!)"
            } else {
                self.recipe["pricePerOne"] = Int(textField.text ?? "0") ?? 0
            }
        case 5:
            guard let ingredientName = textField.text else { return }
            // MARK: 다른 열을 추가한 후에 전의 열에 있는 데이터를 수정하려고 하면 데이터가 중복 저장이됨 - 열을 구분할 수 있는 것이 필요함
//            print("현재 row \(currentRow)")
            if !ingredientName.isEmpty {
//                if currentRow == self.recipeIngredients.count {
                self.recipeIngredient.updateValue(ingredientName, forKey: "ingredientName")
//                } else {
//                    self.recipeIngredients[currentRow]["ingredientName"] = ingredientName
//                }
            } else {
//                if currentRow == self.recipeIngredients.count {
                self.recipeIngredient.removeValue(forKey: "ingredientName")
//                } else if currentRow == self.recipeIngredient.count {
//                    self.recipeIngredients[currentRow]["ingredientName"] = ingredientName
//                }
            }
        case 6:
            guard let totalQ = textField.text else { return }
            if !totalQ.isEmpty {
                let totalQty = exChange(value: totalQ)
                self.recipeIngredient.updateValue(totalQty, forKey: "totalQty")
            } else {
                self.recipeIngredient.removeValue(forKey: "totalQty")
            }
        case 7:
            guard let requiredQ = textField.text else { return }
            if !requiredQ.isEmpty {
                let requiredQty = exChange(value: requiredQ)
                self.recipeIngredient.updateValue(requiredQty, forKey: "requiredQty")
            } else {
                self.recipeIngredient.removeValue(forKey: "requiredQty")
            }
        case 8:
            guard let sharingAvailableQ = textField.text else { return }
            if !sharingAvailableQ.isEmpty {
                let sharingAvailableQty = exChange(value: sharingAvailableQ)
                self.recipeIngredient.updateValue(sharingAvailableQty, forKey: "sharingAvailableQty")
            } else {
                self.recipeIngredient.removeValue(forKey: "sharingAvailableQty")
            }
        default:
            print("")
        }
        
        if self.recipeIngredient.count == 4 {
            self.addButton.isEnabled = true
            self.recipeIngredients.append(self.recipeIngredient)
        } else {
            self.addButton.isEnabled = false
        }
    }
    
    // 값을 분수(1/2)로 받았을때와
    // 소수점으로 받았을때는 잘 들어옴
    func exChange(value: String) -> Double {
        var result: Double = 0.0
        if value.contains("/") {
            var arr: [String] = []
            for (_, i) in value.enumerated() {
                arr.append(String(i))
            }
            let first = Double(arr.first!) ?? 0.0
            let second = Double(arr.last!) ?? 0.0
            result = first/second
            return result
        } else if value.contains(".") {
            result = Double(value)!
            return result
        } else {
            result = Double(value) ?? 0.0
            return result
        }
    }
    
}

extension AddRecipeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "상세내용을 작성해주세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "상세내용을 작성해주세요."
            textView.textColor = .lightGray
        } else {
            self.recipe["content"] = textView.text ?? ""
        }
    }
}
