//
//  PhoneCertifyViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/28.
//

import UIKit
import FirebaseAuth

class PhoneCertifyViewController: UIViewController {
    
    private let phoneCertifyView = PhoneCertifyView()
    private var authVerificationID: String?
    private let phoneNumberFormat = PhoneNumberFormat.init(digits: "")

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
        
        let phoneNumber: String = phoneCertifyView.phoneTextField.text!
        let phone = phoneNumberFormatter(phoneNumber)
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            // Sign in using the verificationID and the code sent to the user
            self.authVerificationID = verificationID
            self.phoneCertifyView.certificationNumberTextField.becomeFirstResponder()
        }
    }
    
    @objc func phoneTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count < 13 {
            textField.text = phoneNumberFormat.addSpacing(at: textField.text!)
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
        let verificationCode: String = phoneCertifyView.certificationNumberTextField.text!

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: authVerificationID!, verificationCode: verificationCode)

        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
            }
            // User is signed in
            let viewController = TermsOfServiceViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func certificationTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count == 6 {
            phoneCertifyView.certificationButton.backgroundColor = .primaryColor
            phoneCertifyView.certificationButton.setTitleColor(.white, for: .normal)
            phoneCertifyView.certificationButton.isEnabled = true
        } else if textField.text!.count > 6 {
            textField.deleteBackward()
        } else {
            phoneCertifyView.certificationButton.backgroundColor = .accentColor
            phoneCertifyView.certificationButton.setTitleColor(.systemGray, for: .normal)
            phoneCertifyView.certificationButton.isEnabled = false
        }
    }
}

// 010 0000 0000 으로 넘어오는 번호를 +8210XXXXXXXX로 바꿔주기
func phoneNumberFormatter(_ phoneNumber: String) -> String {
    let locationNumber = "+82"
    var phone = phoneNumber.filter { $0 != " " }
    phone.removeFirst()
    return locationNumber + phone
}
