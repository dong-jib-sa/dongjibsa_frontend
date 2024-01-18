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
    
    var timer: Timer?
    var timerLeft: Date = "03:00".date!
    var timerEnd: Date = "00:00".date!
    lazy var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    private var certifyCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setupView()
        phoneCertifyView.phoneTextField.becomeFirstResponder()
        viewTappedKeyboardCancel()
        checkedNumberOfCertifications()
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
    
    private func checkedNumberOfCertifications() {
        guard let blockCertify: String = UserDefaults.standard.string(forKey: "blockCertify") else { return }
        let today: String = Date().date!
        if today == blockCertify {
            self.phoneCertifyView.blockCertifyButton.isHidden = false
        } else {
            UserDefaults.standard.removeObject(forKey: "blockCertify")
        }
    }
    
    @objc func phoneButtonTapped(_ sender: UIButton) {
        phoneCertifyView.phoneTextField.resignFirstResponder()
        phoneCertifyView.certificationStackView.isHidden = false
        phoneCertifyView.phoneButton.isEnabled = false
//        phoneCertifyView.feedbackLabel.isHidden = true
//        phoneCertifyView.feedbackButton.isHidden = true
        certifyCount += 1
        
        if certifyCount <= 5 {
            // MEMO: 인증문자 받기 버튼 클릭 시 타이머가 나타나고 끝나면 사라짐
            phoneCertifyView.timerButton.isHidden = false
            formatDuration(from: self.timerEnd, to: self.timerLeft)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimerTicked), userInfo: nil, repeats: true)
            
            let phoneNumber: String = phoneCertifyView.phoneTextField.text!
            let phone = phoneNumberFormatter(phoneNumber)
        
            PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in

                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                // Sign in using the verificationID and the code sent to the user
                self.showToastMessage("인증번호가 발송되었습니다.")

                self.authVerificationID = verificationID
                //            self.phoneCertifyView.certificationNumberTextField.becomeFirstResponder()
            }
        } else {
            // MEMO: 인증횟수 5회 초과 시
            let today: String = Date().date!
            UserDefaults.standard.set(today, forKey: "blockCertify")
            
            self.phoneCertifyView.blockCertifyButton.isHidden = false
            let alert = UIAlertController(title: "일일 인증번호 요청 횟수를 초과했습니다.", message: "24시간 후에 다시 시도해주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    @objc func onTimerTicked() {
        formatDuration(from: timerEnd, to: timerLeft)
        timerLeft -= 1
    }
    
    func formatDuration(from: Date, to: Date) {
        let text = durationFormatter.string(from: to.timeIntervalSince(from))
        self.phoneCertifyView.timerButton.setTitle(text, for: .normal)

        if timerLeft <= timerEnd {
            timer?.invalidate()
            timer = nil
            self.phoneCertifyView.timerButton.isHidden = true
            self.phoneCertifyView.phoneButton.isEnabled = true
            self.phoneCertifyView.phoneButton.setTitle("인증문자 다시 받기", for: .normal)
            timerLeft = "03:00".date!
        }
    }
    
    @objc func phoneTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count < 13 {
            textField.text = phoneNumberFormat.addSpacing(at: textField.text!)
            phoneCertifyView.phoneButton.isEnabled = false
        } else if textField.text!.count == 13 {
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
                // MEMO: 인증 실패 UI
                self.phoneCertifyView.helpMessageLabel.text = "인증번호가 일치하지 않습니다. 다시 인증해주세요."
                self.phoneCertifyView.helpMessageLabel.textColor = .systemRed
                self.phoneCertifyView.certificationNumberTextField.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                // MEMO: 화면전환 -> 전화번호 ? 있음(홈 화면) : 없음(약관)
                // MARK: 입력받은 번호로 저장하는 걸로 수정하기 -> 엔드포인트 구현 후에
                let nickName = NickNameRandom().getRandomNickName()
                Network.shared.postVeripyPhoneNumber(number: "01045674567", nickName: nickName) { result in
                    switch result {
                    case "이미 존재하는 회원입니다.":
                        DispatchQueue.main.async {
                            let main = UIStoryboard.init(name: "Main", bundle: nil)
                            let viewController = main.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
                            viewController.modalPresentationStyle = .fullScreen
                            self.present(viewController, animated: false)
                        }
                    case "신규 회원입니다. 약관 동의 후 회원 가입을 진행합니다.":
                        DispatchQueue.main.async {
                            let viewController = TermsOfServiceViewController()
                            viewController.loginType = .phoneNumber
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    default:
                        print()
                    }
                }
            }
        }
    }
    
    @objc func certificationTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count == 6 {
            phoneCertifyView.certificationButton.isEnabled = true
        } else if textField.text!.count > 6 {
            textField.deleteBackward()
        } else {
            phoneCertifyView.certificationButton.isEnabled = false
            self.phoneCertifyView.certificationNumberTextField.layer.borderColor = UIColor.systemGray.cgColor
        }
    }
    
    func showToastMessage(_ message: String) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = .systemGray.withAlphaComponent(0.8)
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 12)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true
        
        self.view.addSubview(toastLabel)
        toastLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
            make.width.equalTo(335)
            make.height.equalTo(30)
        }
        
        UIView.animate(withDuration: 2, delay: 1.5, options: .curveEaseOut) {
            toastLabel.alpha = 0.0
        } completion: { isCompleted in
            toastLabel.removeFromSuperview()
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
