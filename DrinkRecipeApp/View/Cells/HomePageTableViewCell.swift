//
//  HomePageTableViewCell.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 5/31/21.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    static let identifier = "HomePageTableViewCell"
    
    @IBOutlet weak var drinkImage: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

}
