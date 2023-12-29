//
//  CustomButton.swift
//  DongJibSa
//
//  Created by heyji on 2023/12/29.
//

import UIKit

class CustomButton: UIButton {
    
    private var defaultBackgroundColor: UIColor = .accentColor
    private var disabledBackgroundColor: UIColor = .primaryColor
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = disabledBackgroundColor
                self.setTitleColor(.white, for: .normal)
            }
            else {
                self.backgroundColor = defaultBackgroundColor
                self.setTitleColor(.systemGray, for: .normal)
            }
        }
    }
}
