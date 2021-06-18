//
//  HomePageCollectionViewCell.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/15/21.
//

import UIKit

class HomePageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage, name: String) {
        imageView.image = image
        categoryName.text = name
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "HomePageCollectionViewCell", bundle: nil)
    }

}
