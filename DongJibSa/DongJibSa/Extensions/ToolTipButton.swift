//
//  ToolTipButton.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/19.
//

import UIKit

class ToolTipButton: UIButton {
    private let toolTipView = CalorieCell()
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                toolTipView.toolTipView.isHidden = false
            }
            else {
                toolTipView.toolTipView.isHidden = true
            }
        }
    }
}
