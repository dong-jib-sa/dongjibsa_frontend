//
//  TermsOfServiceViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/29.
//

import UIKit

class TermsOfServiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setupView()
    }
    
    private func setNavigationBar() {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 23))
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setPreferredSymbolConfiguration(.init(pointSize: 23), forImageIn: .normal)
        backButton.tintColor = .bodyColor
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
