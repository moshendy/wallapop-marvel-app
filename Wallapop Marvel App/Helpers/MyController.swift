//
//  MyController.swift
//  Created by shendy on 5/31/20.
//

import UIKit
import SystemConfiguration
import SDWebImage
import Spring
//import Lottie
//import PhoneNumberKit

class MyController {
    
    public static func isValidEmail(emailAddress:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailAddress)
    }
    
    public static func isEmptyString(text: String) -> Bool {
        if text.isEmpty {
            return true
        }
        if text == "" {
            return true
        }
        if text.count == 0 {
            return true
        }
        return false
    }
    
    public static func coloredString(mainString: String,coloredString: String,newColor: UIColor) -> NSAttributedString{
        
        let range = (mainString as NSString).range(of: coloredString)
        
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: newColor, range: range)
        
        return mutableAttributedString
    }
    
    public static func openUrl(mainUrl:String,scondaryUrl:String , schema:String) {
        
        let strUrl: String = mainUrl
        
        if UIApplication.shared.canOpenURL(URL(string: schema)!) {
            let url = URL(string: strUrl)!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else {
            
            if let url = URL(string: scondaryUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    public static func makeCall(_ phone:String) {
        if let url  = URL(string:"tel://\(phone)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(url)) {
                application.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    //    public static func phoneNumberParse(phoneNo:String) -> String {
    //        var phNo = ""
    //        let phoneNumberKit = PhoneNumberKit()
    //        do {
    //            let phoneNumber = try phoneNumberKit.parse(phoneNo)
    //            phNo  = String(describing:phoneNumber.nationalNumber)
    //        }
    //        catch {
    //        }
    //        return phNo
    //    }
    
    public static func isConnectedToInternet() -> Int{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return 0
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return 0
        }
        
        let isReachable = flags.contains(.reachable)
        
        if isReachable{
            return 1
        }else{
            return 0
            
        }
    }
    
    public static func formatNumbers(_ n: Int) -> String {
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"
            
        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"
            
        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"
            
        case 0...:
            return "\(n)"
            
        default:
            return "\(sign)\(n)"
        }
    }
    
    public static func viewAlertDialog(vc:UIViewController, title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: "ok"), style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Loading Indicator
    //-------------------------

    
    public static func showDefaultLoading(vc: UIViewController,blur:Bool,Dark:Bool = false,colorName : UIColor){
        vc.view.isUserInteractionEnabled = false

        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = colorName
        let myView = UIView()
        activityView.center = myView.center
        
        if blur{
            if Dark{
                myView.setBlurViewDark()
            }else{
                myView.setBlurView()
            }
        }
        
        myView.tag = 999
        myView.addSubview(activityView)
        vc.view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: myView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: vc.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: myView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: vc.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: myView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: myView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        vc.view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        activityView.startAnimating()
    }
    
    public static func hideLoading(vc: UIViewController , timeSeconds: Double = 0){
        DispatchQueue.main.asyncAfter(deadline: .now() + timeSeconds) {
            vc.view.isUserInteractionEnabled = true
            let subViews = vc.view.subviews
            for subview in subViews{
                if subview.tag == 999 {
                    subview.removeFromSuperview()
                }
            }
        }
    }

    //Lottie
    //---------------------
    
    //    public static func showGIF(vc: UIViewController,nameGIF:String,blur:Bool,animationSpeed:Double){
    //        vc.view.isUserInteractionEnabled = false
    //        let screenSize: CGRect = UIScreen.main.bounds
    //        var animationView = AnimationView()
    //        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
    //        myView.tag = 999
    //
    //        if blur{
    //            myView.setBlurViewDark()
    //        }
    //
    //        animationView = .init(name: nameGIF)
    //        animationView.frame = CGRect(x: (screenSize.width/2)-150, y: (screenSize.width/2)+150, width: 300, height: 300)
    //        animationView.contentMode = .scaleAspectFit
    //        animationView.loopMode = .loop
    //        animationView.animationSpeed = animationSpeed
    //
    //        myView.addSubview(animationView)
    //        vc.view.addSubview(myView)
    //        animationView.play()
    //    }
    //End Lottie
    //-----------------------------
    
    //MARK: Handle Dates and Times
    //---------------------
    
    
    public static func calculateAge(birthday:String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        if birthdayDate != nil {
            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let calcAge = calendar.components(.year, from: birthdayDate!, to: Date(), options: [])
            let age = calcAge.year
            return age!
        }
        
        return 0
    }
    public static func differenceBetweenDates(_ date1:Date,_ date2:Date) -> [Int] {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.minute], from: date1, to: date2)
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        return [days,hours,minutes,seconds]
    }
    
    public static func stringToDate(sDate:String, format:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en")
        let date = formatter.date(from: sDate)
        return date!
    }
    public static func dateToString(date:Date, format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    public static func getDateOnly(date:Date, format:String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        let today = formatter.string(from: date)
        return today
    }
    public static func getTimeOnly(_ date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        let dateString = formatter.string(from: date)
        return dateString
    }
    public static func getDayNameOnly(date : Date) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEE"
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        let today = formatter.string(from:date)
        return today
    }
    
}




