//
//  HomePageTableViewCell.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/15/21.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    @IBOutlet var drinkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier = "HomePageTableViewCell"
    
    public func configure(with image: UIImage, name: String) {
        drinkImageView.image = image
        nameLabel.text = name
    }
  
}
