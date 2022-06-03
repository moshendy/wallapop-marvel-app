//
//  MyDataTypeExtensions.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import UIKit


extension String{
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    var isUrlValid : Bool {
        if let url = URL.init(string: self){
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    func ArNumberToEn() -> String {
        let Formatter: NumberFormatter = NumberFormatter()
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        let finaltxtNo = Formatter.number(from: self)
        return "00\(finaltxtNo!)"
    }
    func replacePlusInCountruCode() -> String {
        let result = self.replacingOccurrences(of: "+", with: "00")
        return  "\(result)"
    }
    var replaceZerosInCountruCode : String {
        let result = self.dropFirst(2).description
        return  "+\(result)"
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
    
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    static var today:  Date { return Date().today }
    static var threedays:  Date { return Date().threedayss }
    static var twoHours:  Date { return Date().twoHours }
    
    var twoHours: Date {
        return Calendar.current.date(byAdding: .hour, value: +2, to: noon)!
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var today: Date {
        return Calendar.current.date(byAdding: .day, value: 0, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var threedayss: Date {
        return Calendar.current.date(byAdding: .day, value: 3, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
