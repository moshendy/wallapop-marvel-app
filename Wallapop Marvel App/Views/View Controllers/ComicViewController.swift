//
//  ComicViewController.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 04/06/2022.
//

import UIKit

class ComicViewController: UIViewController {

    @IBOutlet weak var scrollViewMainWidth: NSLayoutConstraint!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    @IBOutlet weak var comicLabel: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var focDateLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!

    var format = ""
    var focDate = ""
    var onSaleDate = ""

    var comicTitle = ""
    var comicDescription = ""
    var pageCount = 0
    var image = ""
    var price = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        comicLabel.text = comicTitle
        comicDescriptionLabel.text = comicDescription.replacingOccurrences(of: "<br>", with: "\n", options: .literal, range: nil)
        priceLabel.text = "Price: \(price)"
        formatLabel.text = "Format: \(format)"
        
        if let newDate = MyController.convertISODate(dateString: onSaleDate){
            publishedDateLabel.text = "Published Date: \(newDate)"
        }else{
            publishedDateLabel.text = ""
        }
        if let newDate = MyController.convertISODate(dateString: focDate){
            focDateLabel.text = "FocDate: \(newDate)"
        }else{
            focDateLabel.text = ""
        }

        
        
        let stringURL = "\(image)\(ApisURL.imagePortraitExt)jpg"
        if stringURL.contains("image_not_available") {
            comicImage.image = UIImage(named: "mainLogo")
        }else{
            comicImage.sd_setImage(with: URL(string: stringURL ), placeholderImage: UIImage(named: "mainLogo"))
        }

    }
    
    override func viewWillLayoutSubviews() {
        scrollViewMainWidth.constant = UIScreen.main.bounds.width
    }


}
