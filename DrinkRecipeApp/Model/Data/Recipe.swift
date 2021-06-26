//
//  Recipe.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/4/21.
//

import Foundation
import UIKit

class Recipe {
    var id : String?
    var name : String?
    var alternate : String?
    var tags : String?
    var category : String?
    var iba : String?
    var alcoholic : String?
    var glass : String?
    var instructions : String?
    var image : Data?
    var imageUrl : String?
    var ingredients = [String: String]()
    
    init(drinkModel: DrinkModel ) {
        id = drinkModel.id
        name = drinkModel.name
        alternate = drinkModel.drinkAlternative
        tags = drinkModel.tags
        category = ""
        iba = drinkModel.iba
        alcoholic = drinkModel.alchoholic
        glass = drinkModel.glass
        instructions = drinkModel.instructions
        image = drinkModel.thumbImage
        
        drinkModel.ingredients?.forEach{ing  in
            self.ingredients[(ing as! IngredientModel).name!] = (ing as! IngredientModel).measure
        }
    }
    
    init(drink: Drink) {
        id = drink.idDrink
        name = drink.strDrink
        alternate = drink.strDrinkAlternate
        tags = drink.strTags
        category = drink.strCategory
        iba = drink.strIBA
        alcoholic = drink.strAlcoholic
        glass = drink.strGlass
        instructions = drink.strInstructions
        imageUrl = drink.strDrinkThumb
        
        if let _ = drink.strIngredient1 {
            if let measure = drink.strMeasure1 {
                ingredients.updateValue(measure, forKey: drink.strIngredient1!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient1!)
            }
        }
        
        if let _ = drink.strIngredient2 {
            if let measure = drink.strMeasure2 {
                ingredients.updateValue(measure, forKey: drink.strIngredient2!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient2!)
            }
        }
        
        if let _ = drink.strIngredient3 {
            if let measure = drink.strMeasure3 {
                ingredients.updateValue(measure, forKey: drink.strIngredient3!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient3!)
            }
        }
        
        if let _ = drink.strIngredient4 {
            if let measure = drink.strMeasure4 {
                ingredients.updateValue(measure, forKey: drink.strIngredient4!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient4!)
            }
        }
        
        if let _ = drink.strIngredient5 {
            if let measure = drink.strMeasure5 {
                ingredients.updateValue(measure, forKey: drink.strIngredient5!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient5!)
            }
        }
        
        if let _ = drink.strIngredient6 {
            if let measure = drink.strMeasure6 {
                ingredients.updateValue(measure, forKey: drink.strIngredient6!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient6!)
            }
        }
        
        if let _ = drink.strIngredient7 {
            if let measure = drink.strMeasure7 {
                ingredients.updateValue(measure, forKey: drink.strIngredient7!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient7!)
            }
        }
        
        if let _ = drink.strIngredient8 {
            if let measure = drink.strMeasure8 {
                ingredients.updateValue(measure, forKey: drink.strIngredient8!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient8!)
            }
        }
        
        if let _ = drink.strIngredient9 {
            if let measure = drink.strMeasure9 {
                ingredients.updateValue(measure, forKey: drink.strIngredient9!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient9!)
            }
        }
        
        if let _ = drink.strIngredient10 {
            if let measure = drink.strMeasure10 {
                ingredients.updateValue(measure, forKey: drink.strIngredient10!)
            } else {
                ingredients.updateValue(String("¯\\_(ツ)_/¯"), forKey: drink.strIngredient10!)
            }
        }
    }
}
