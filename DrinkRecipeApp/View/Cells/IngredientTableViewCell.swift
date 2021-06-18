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

//        var configuration = defaultContentConfiguration().updated(for: state)
        var bgConfiguration = backgroundConfiguration?.updated(for: state)

//        configuration.text = textLabel?.text
        
        if state.isHighlighted || state.isSelected {
//            configuration.text = textLabel?.text
//            configuration.textProperties.color = .white
//            configuration.imageProperties.tintColor = .green
            bgConfiguration?.backgroundColor = .white
        }
        print("In the cell file here is the text \(textLabel?.text)")
//        contentConfiguration = configuration
        backgroundConfiguration = bgConfiguration

    }
}
