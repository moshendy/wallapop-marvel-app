//
//  ComicTableViewCell.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import UIKit

class ComicTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!

    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    
    var cellViewModel: ComicCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.title
            
            let stringURL = "\(cellViewModel?.image ?? "")\(ApisURL.imageExt)\(cellViewModel?.imageExt ?? "")"
            if stringURL.contains("image_not_available") {
                cellImage.image = UIImage(named: "mainLogo")
            }else{
                cellImage.sd_setImage(with: URL(string: stringURL ), placeholderImage: UIImage(named: "mainLogo"))
            }
        }
    }

}
