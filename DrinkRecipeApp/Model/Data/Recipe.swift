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
//    var ingredients : [String: String]?
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
        category = ""
        iba = drink.strIBA
        alcoholic = drink.strAlcoholic
        glass = drink.strGlass
        instructions = drink.strInstructions
        image = nil
        
        if let _ = drink.strIngredient1 {
            ingredients.updateValue(drink.strMeasure1!, forKey: drink.strIngredient1!)
//            ingredients?[drink.strIngredient1!] = drink.strMeasure1
                                        
        }
        
        if let _ = drink.strIngredient2 {
            ingredients.updateValue(drink.strMeasure2!, forKey: drink.strIngredient2!)
//            ingredients?[drink.strIngredient2!] = drink.strMeasure2
        }
        
        if let _ = drink.strIngredient3 {
            ingredients.updateValue(drink.strMeasure3!, forKey: drink.strIngredient3!)
//            ingredients?[drink.strIngredient3!] = drink.strMeasure3
        }
        
        if let _ = drink.strIngredient4 {
            ingredients.updateValue(drink.strMeasure4!, forKey: drink.strIngredient4!)
//            ingredients?[drink.strIngredient4!] = drink.strMeasure4
        }
        
//        if let _ = drink.strIngredient5 {
//            ingredients?[drink.strIngredient5!] = drink.strMeasure5
//        }
//        
//        if let _ = drink.strIngredient6 {
//            ingredients?[drink.strIngredient6!] = drink.strMeasure6
//        }
//        
//        if let _ = drink.strIngredient7 {
//            ingredients?[drink.strIngredient7!] = drink.strMeasure7
//        }
//        
//        if let _ = drink.strIngredient8 {
//            ingredients?[drink.strIngredient8!] = drink.strMeasure8
//        }
//        
//        if let _ = drink.strIngredient9 {
//            ingredients?[drink.strIngredient9!] = drink.strMeasure9
//        }
//        
//        if let _ = drink.strIngredient10 {
//            ingredients?[drink.strIngredient10!] = drink.strMeasure10
//        }
//        
//        if let _ = drink.strIngredient11 {
//            ingredients?[drink.strIngredient11!] = drink.strMeasure11
//        }
//        
//        if let _ = drink.strIngredient12 {
//            ingredients?[drink.strIngredient12!] = drink.strMeasure12
//        }
//        
//        if let _ = drink.strIngredient13 {
//            ingredients?[drink.strIngredient13!] = drink.strMeasure13
//        }
//        
//        if let _ = drink.strIngredient14 {
//            ingredients?[drink.strIngredient14!] = drink.strMeasure14
//        }
//        
//        if let _ = drink.strIngredient15 {
//            ingredients?[drink.strIngredient15!] = drink.strMeasure15
//        }
    }
}
