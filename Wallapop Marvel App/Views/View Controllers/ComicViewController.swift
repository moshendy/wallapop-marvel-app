//
//  ComicViewController.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 04/06/2022.
//

import UIKit

class ComicViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var scrollViewMainWidth: NSLayoutConstraint!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    @IBOutlet weak var comicLabel: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var focDateLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!

    //MARK: - Global Variables

    var format = "Comic"
    var focDate = "1-6-2022"
    var onSaleDate = "1-6-2022"

    var comicTitle = "Avengers"
    var comicDescription = "Hello There"
    var price = 2.99

    var imageui : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Set Comic Data to View before the view appears
    override func viewWillAppear(_ animated: Bool) {
        
        comicLabel.text = comicTitle
        priceLabel.text = "Price: $\(price) "
        formatLabel.text = "Format: \(format)"
        comicDescriptionLabel.text = comicDescription.replacingOccurrences(of: "<br>", with: "\n", options: .literal, range: nil)

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

        comicImage.image = imageui

        scrollViewMainWidth.constant = UIScreen.main.bounds.width
        self.view.layoutIfNeeded()

    }
}
