//
//  IngredientTableViewCell.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/5/21.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    static let identifier = "IngredientTableViewCell"
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(label: String) {
        textLabel?.text = label
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        var bgConfiguration = backgroundConfiguration?.updated(for: state)
        if state.isHighlighted || state.isSelected {
            bgConfiguration?.backgroundColor = .white
        }
         backgroundConfiguration = bgConfiguration

    }
}
