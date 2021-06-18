//
//  DrinklTableViewCell.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/5/21.
//

import UIKit

class DrinklTableViewCell: UITableViewCell {
    
    static let identifier = "DrinklTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DrinklTableViewCell", bundle: nil)
    }
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var catgoryLabel: UILabel!
    @IBOutlet weak var glassLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
