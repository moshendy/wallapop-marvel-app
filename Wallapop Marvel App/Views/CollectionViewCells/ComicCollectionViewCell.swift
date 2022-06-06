//
//  ComicCollectionViewCell.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 04/06/2022.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainVIew: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!

    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    
    var cellViewModel: ComicCellViewModel? {
        didSet {
            
            mainVIew.ShadowUIView()
            nameLabel.text = cellViewModel?.title

            let stringURL = "\(cellViewModel?.image ?? "")\(ApisURL.imageStandardExt)\(cellViewModel?.imageExt ?? "")"
            if stringURL.contains("image_not_available") {
                cellImage.image = UIImage(named: "mainLogo")
            }else{
                cellImage.sd_setImage(with: URL(string: stringURL ), placeholderImage: UIImage(named: "mainLogo"))
            }
        }
    }
}
