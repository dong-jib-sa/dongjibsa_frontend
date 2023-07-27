//
//  Extension.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/27.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    static var primaryColor: UIColor {
        UIColor(named: "primaryColor") ?? UIColor(hex: 0x5EB14E)
    }
    
    static var bodyColor: UIColor {
        UIColor(named: "bodyColor") ?? UIColor(hex: 0x454F5B)
    }
    
    static var headerColor: UIColor {
        UIColor(named: "headerColor") ?? UIColor(hex: 0x212B36)
    }
    
    static var accentColor: UIColor {
        UIColor(named: "accentColor") ?? UIColor(hex: 0xDFEFDC)
    }
}
