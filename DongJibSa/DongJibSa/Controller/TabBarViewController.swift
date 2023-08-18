//
//  TabBarViewController.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/27.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .primaryColor
        UITabBar.appearance().unselectedItemTintColor = .bodyColor
    }
}
