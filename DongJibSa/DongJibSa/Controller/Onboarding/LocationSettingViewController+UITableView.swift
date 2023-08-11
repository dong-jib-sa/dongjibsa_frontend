//
//  LocationSettingViewController+UITableView.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/11.
//

import UIKit

extension LocationSettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == guTableView {
            return guLocation.count
        } else {
            return dongLocation.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == guTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: GuTableViewCell.cellId, for: indexPath) as! GuTableViewCell
            cell.titleLabel.text = guLocation[indexPath.row]
            if indexPath.row == 0 {
                cell.isSelected = true
            }
            return cell
        } else if tableView == dongTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: DongTableViewCell.cellId, for: indexPath) as! DongTableViewCell
            cell.titleLabel.text = dongLocation[indexPath.row]
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == dongTableView {
            if selectLocation.isEmpty {
                let location = dongLocation[indexPath.row]
                selectLocation.append(location)
                self.collectionView.reloadData()
            } else {
                selectLocation = []
                let location = dongLocation[indexPath.row]
                selectLocation.append(location)
                self.collectionView.reloadData()
            }
            saveButton.backgroundColor = .primaryColor
            saveButton.setTitleColor(.white, for: .normal)
        } else if tableView == guTableView {
            
        }
    }
}
