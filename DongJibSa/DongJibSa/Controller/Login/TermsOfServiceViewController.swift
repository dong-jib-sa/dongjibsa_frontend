//
//  TermsOfServiceViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/29.
//

import UIKit

class TermsOfServiceViewController: UIViewController {
    
    private let termsOfServiceView = TermsOfServiceView()

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
        
        self.view.addSubview(termsOfServiceView)
        termsOfServiceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        termsOfServiceView.agreementButton.addTarget(self, action: #selector(agreementButtonTapped), for: .touchUpInside)
        termsOfServiceView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func agreementButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.tintColor = .primaryColor
            termsOfServiceView.isSelected.toggle()
            termsOfServiceView.startButton.backgroundColor = .primaryColor
            termsOfServiceView.startButton.setTitleColor(.white, for: .normal)
            termsOfServiceView.startButton.isEnabled.toggle()
        } else {
            sender.tintColor = .systemGray
            termsOfServiceView.isSelected.toggle()
            termsOfServiceView.startButton.backgroundColor = .accentColor
            termsOfServiceView.startButton.setTitleColor(.systemGray, for: .normal)
            termsOfServiceView.startButton.isEnabled.toggle()
        }
    }
    
    @objc func startButtonTapped(_ sender: UIButton) {
        // MEMO: 동네설정 블라인드 처리
//        let viewController = LocationSettingViewController(selectLocation: [])
//        self.navigationController?.navigationBar.tintColor = .bodyColor
//        self.navigationItem.backButtonDisplayMode = .minimal
//        self.navigationController?.pushViewController(viewController, animated: true)
        
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = main.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false)
    }
}
