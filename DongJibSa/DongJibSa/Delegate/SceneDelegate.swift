//
//  SceneDelegate.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/27.
//

import UIKit
import KakaoSDKAuth
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        // 온보딩 페이지 -> 처음 앱 실행 시에 한 번만
        if UserDefaults.standard.bool(forKey: "OnboardingPage") {
            let login = UIStoryboard.init(name: "Login", bundle: nil)
            let loginViewController = login.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            let navigationController = UINavigationController(rootViewController: loginViewController)
            navigationController.modalPresentationStyle = .fullScreen
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        } else {
            UserDefaults.standard.set(true, forKey: "OnboardingPage")
            let onboarding = UIStoryboard.init(name: "Onboarding", bundle: nil)
            let onboardingViewController = onboarding.instantiateViewController(identifier: "OnboardingViewController") as! OnboardingViewController
            window.rootViewController = onboardingViewController
            window.makeKeyAndVisible()
        }
        
//        if let urlContext = connectionOptions.urlContexts.first {
//            let sendingAppID = urlContext.options.sourceApplication
//            print("sendingAppID: \(sendingAppID ?? "Unknown")")
//        }
        
    }
    
    // 카카오톡으로 로그인을 위한 설정
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

