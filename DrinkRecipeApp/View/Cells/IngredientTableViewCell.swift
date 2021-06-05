//
//  IngredientTableViewCell.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/5/21.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    static let identifier = "IngredientTableViewCell"
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
            
        var configuration = defaultContentConfiguration().updated(for: state)
        configuration.text = "\(String(""))"
        
        contentConfiguration = configuration
        
    }
}
