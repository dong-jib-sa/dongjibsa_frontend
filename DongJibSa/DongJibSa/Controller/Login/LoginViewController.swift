//
//  LoginViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/24.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }
    
    private func setNavigationBar() {
        var attString = AttributedString("둘러보기")
        attString.font = .systemFont(ofSize: 12, weight: .regular)
        attString.foregroundColor = .systemGray
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attString
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 6
        
        let skipButton = UIButton(configuration: configuration)
        skipButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        skipButton.setPreferredSymbolConfiguration(.init(pointSize: 12), forImageIn: .normal)
        skipButton.tintColor = .systemGray
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        
        let skipItem = UIBarButtonItem(customView: skipButton)
        self.navigationItem.rightBarButtonItem = skipItem
    }
    
    @objc func skipButtonTapped(_ sender: UIButton) {
        let viewController = LocationSettingViewController(selectLocation: [])
        self.navigationController?.navigationBar.tintColor = .bodyColor
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
