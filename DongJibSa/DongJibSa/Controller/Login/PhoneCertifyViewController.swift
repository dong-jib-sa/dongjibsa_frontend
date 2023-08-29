//
//  PhoneCertifyViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/28.
//

import UIKit

class PhoneCertifyViewController: UIViewController {
    
    private let phoneCertifyView = PhoneCertifyView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setupView()
        phoneCertifyView.phoneTextField.becomeFirstResponder()
        viewTappedKeyboardCancel()
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
        
        self.view.addSubview(phoneCertifyView)
        phoneCertifyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        phoneCertifyView.phoneButton.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
        phoneCertifyView.phoneTextField.addTarget(self, action: #selector(phoneTextFieldDidChange), for: .editingChanged)
        phoneCertifyView.certificationButton.addTarget(self, action: #selector(certificationButtonTapped), for: .touchUpInside)
        phoneCertifyView.certificationNumberTextField.addTarget(self, action: #selector(certificationTextFieldDidChange), for: .editingChanged)
    }
    
    private func viewTappedKeyboardCancel() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func phoneButtonTapped(_ sender: UIButton) {
        phoneCertifyView.phoneTextField.resignFirstResponder()
        phoneCertifyView.certificationStackView.isHidden = false
        phoneCertifyView.feedbackLabel.isHidden = true
        phoneCertifyView.feedbackButton.isHidden = true
        phoneCertifyView.helpButton.isHidden = false
    }
    
    @objc func phoneTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count < 13 {
            if textField.text!.count == 3 || textField.text!.count == 8 {
                textField.text! += " "
            }
            phoneCertifyView.phoneButton.backgroundColor = .accentColor
            phoneCertifyView.phoneButton.setTitleColor(.systemGray, for: .normal)
            phoneCertifyView.phoneButton.isEnabled = false
        } else if textField.text!.count == 13 {
            phoneCertifyView.phoneButton.backgroundColor = .primaryColor
            phoneCertifyView.phoneButton.setTitleColor(.white, for: .normal)
            phoneCertifyView.phoneButton.isEnabled = true
        } else {
            textField.deleteBackward()
        }
    }
    
    @objc func certificationButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func certificationTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count == 6 {
            phoneCertifyView.certificationButton.backgroundColor = .primaryColor
            phoneCertifyView.certificationButton.setTitleColor(.white, for: .normal)
            phoneCertifyView.certificationButton.isEnabled = true
        } else {
            phoneCertifyView.certificationButton.backgroundColor = .accentColor
            phoneCertifyView.certificationButton.setTitleColor(.systemGray, for: .normal)
            phoneCertifyView.certificationButton.isEnabled = false
        }
    }
}
