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

extension UITextField {
    func addPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
    func toStyledTextField(_ textField: UITextField) {
        textField.backgroundColor = .systemGray6
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
    }
}

extension UILabel {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 2
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    /// Finds the current first responder
    /// - Returns: the current UIResponder if it exists
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}

extension String {
    func getStringIndex(i: Int) -> String.Index {
        return self.index(self.startIndex, offsetBy: i)
    }
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
    
    static var dateFormatterLong: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var dateLong: Date? {
        return String.dateFormatterLong.date(from: self)
    }
}

extension Date {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: String? {
        return Date.dateFormatter.string(from: self)
    }
    
    var dayAndTimeText: String {
        let timeText = Date.timeFormatter.string(from: self)
        if Locale.current.calendar.isDateInToday(self) {
            let timeFormat = NSLocalizedString("%@", comment: "Today at time format string")
            return String(format: timeFormat, timeText) // 오늘 오후 ㅁ시
        } else if Locale.current.calendar.isDateInYesterday(self) {
            let dateAndTimeFormat = NSLocalizedString("%@, %@", comment: "Today at time format string")
            return String(format: dateAndTimeFormat) // 어제 10월 14일, ㅁ시, 오후 ㅁ시
        } else {
            // 현재년도 일때와 아닐때 구분
            let currentYear = Date.now
            if Locale.current.calendar.isDate(currentYear, equalTo: self, toGranularity: .year) {
                let dateText = formatted(.dateTime.month(.wide).day().locale(Locale(identifier: "ko_KR")))
                let dateAndTimeFormat = NSLocalizedString("%@, %@", comment: "Date and time format string")
                return String(format: dateAndTimeFormat, dateText, timeText) // 10월 14일, ㅁ시, 오후 ㅁ시
            } else {
                let dateText = formatted(.dateTime.year().month(.wide).day().locale(Locale(identifier: "ko_KR")))
                let dateAndTimeFormat = NSLocalizedString("%@, %@", comment: "Date and time format string")
                return String(format: dateAndTimeFormat, dateText, timeText) // 10월 14일, 2022, ㅁ시, 오후 ㅁ시
            }
        }
    }
    
    static var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var timeFormat: String {
        return Date.timeFormatter.string(from: self)
    }
    
    static var dateLongFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var dateLongFormat: String {
        return Date.dateLongFormatter.string(from: self)
    }
}

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "SecureAPIKeys", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String else {
            fatalError("API KEY를 가져오는데 실패하였습니다.")
        }
        return key
    }
}
