//
//  ToolTip.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/19.
//

import UIKit

class ToolTip: UIView {
    private let bgColor = UIColor.systemGray
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .clear
        bgColor.setFill()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.close()
        path.fill()
    }
}
