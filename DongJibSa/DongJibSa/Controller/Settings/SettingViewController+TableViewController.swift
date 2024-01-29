//
//  SettingViewController+TableViewController.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/02.
//

import UIKit
import SafariServices
import KakaoSDKUser
import FirebaseAuth

extension SettingViewController: UITableViewDataSource, UITableViewDelegate, CustomAlertDelegate {
    
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSettingTableViewCell.cellId, for: indexPath) as! DefaultSettingTableViewCell
        let title = sections[indexPath.row]
        let content = contents[indexPath.row]
        cell.configure(title: title, content: content)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "고객지원"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // MEMO: 약관 및 정책
            guard let url = URL(string: "https://silicon-planarian-e5b.notion.site/c0a06cd9119242708ab55839192df8b6") else { return }
            let safari = SFSafariViewController(url: url)
            present(safari, animated: true)
        case 2:
            // MEMO: 로그아웃
            let viewController = UIStoryboard.init(name: "Login", bundle: nil)
            let loginViewController = viewController.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
    //
            self.view.window?.rootViewController?.dismiss(animated: true, completion: {
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                guard let rootViewController = sceneDelegate.window?.rootViewController as? LoginViewController else { return }
            })
//            let viewController = UIStoryboard.init(name: "Onboarding", bundle: nil)
//            let onboardingViewController = viewController.instantiateViewController(identifier: "OnboardingViewController") as! OnboardingViewController
//            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(onboardingViewController)
            print("로그아웃되었습니다.")
        case 3:
            // MEMO: 회원탈퇴
            let viewController = CustomAlertViewController(title: "정말 탈퇴 하시겠어요?", greenColorButtonTitle: "아니요", grayColorButtonTitle: "탈퇴하기", customAlertType: .doneAndCancel, alertHeight: 320)
            viewController.delegate = self
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true)
        default:
            break
        }
    }
    
    func action() {
        // ["result": 3번 회원의 탈퇴가 완료되었습니다., "resultCode": SUCCESS!]
        Network.shared.deleteUserLogout()
        guard let loginType = UserDefaults.standard.string(forKey: "LoginType") else { return }
        switch loginType {
        case LoginType.apple.title:
            print()
        case LoginType.kakao.title:
            UserApi.shared.unlink {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("unlink() success.")
                }
            }
        case LoginType.phoneNumber.title:
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
        default:
            print()
        }
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        
//        let params: [String: Any] = ["is_active": false]
//        NetworkService.shared.patchUserIsActiveRequest(parameters: params)
//
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
        let viewController = UIStoryboard.init(name: "Login", bundle: nil)
        let loginViewController = viewController.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
//
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            guard let rootViewController = sceneDelegate.window?.rootViewController as? LoginViewController else { return }
        })
    }

    func exit() {

    }
    
    // MEMO: 두번째 셀은 선택이 되지 않도록 설정
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 1
    }
    
    // MEMO: 현재 버전 가져오기
    func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return "v \(version)"
    }
}
