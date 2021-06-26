//
//  IngredientTableViewCell.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/5/21.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    static let identifier = "IngredientTableViewCell"
    @IBOutlet weak var ingredientActivityIndicator: UIActivityIndicatorView!
    
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
    
    public func startActivityIndicator() {
        ingredientActivityIndicator.isHidden = false
        ingredientActivityIndicator.startAnimating()
    }
    
    public func stopActivityIndicator() {
        ingredientActivityIndicator.isHidden = true
        ingredientActivityIndicator.stopAnimating()
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
