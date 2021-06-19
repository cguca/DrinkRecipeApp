//
//  CocktailCoreDataService.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/13/21.
//

import UIKit
import CoreData

class CocktailCoreDataService {
    
    static let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    class func getShoppingListItem(name: String) -> ShoppingListModel? {
        let fetchRequest: NSFetchRequest<ShoppingListModel> = ShoppingListModel.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        if let result = try? viewContext.fetch(fetchRequest) {
            if result.count > 0 {
                return result.first!
            }
        }
        return nil
    }
    
    class func deleteShoppingItem(name: String) {
        let fetchRequest: NSFetchRequest<ShoppingListModel> = ShoppingListModel.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        if let result = try? viewContext.fetch(fetchRequest) {
            result.forEach { drink in
                viewContext.delete(drink)
            }
            try? viewContext.save()
        }
    }
    
    class func saveShoppingListItem(name: String, imageData: Data) {
        let shoppingListModel = ShoppingListModel(context: viewContext)
        shoppingListModel.name = name
        shoppingListModel.image = imageData
        do {
            try viewContext.save()
        }  catch {
            print("There was an error while saving the image to core data: \(error.localizedDescription)")
        }
    }
    
    class func getSavedFavorites() -> [DrinkModel]{
        let fetchRequest: NSFetchRequest<DrinkModel> = DrinkModel.fetchRequest()
        if let result = try? viewContext.fetch(fetchRequest) {
            if result.count > 0 {
                return result
            }
        }
        return [DrinkModel]()
    }
    
    class func getSavedFavorite(id: String) -> DrinkModel? {
        
        let fetchRequest: NSFetchRequest<DrinkModel> = DrinkModel.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        if let result = try? viewContext.fetch(fetchRequest) {
            if result.count > 0 {
                return result.first!
            }
        }
        return nil
    }
    
    class func saveToFavorites(recipe: Recipe) throws {
        let drinkModel = DrinkModel(context: viewContext)
        drinkModel.id = recipe.id
        drinkModel.alchoholic = recipe.alcoholic
        drinkModel.drinkAlternative = recipe.alternate
        drinkModel.glass = recipe.glass
        drinkModel.iba = recipe.iba
        drinkModel.instructions = recipe.instructions
        drinkModel.name = recipe.name
        drinkModel.tags = recipe.tags
        drinkModel.thumbImage = recipe.image
        
        let ingredients = recipe.ingredients
        ingredients.forEach({ (key, value) in
            let ingredientModel = IngredientModel(context: viewContext)
            ingredientModel.name = key
            ingredientModel.measure = value
            ingredientModel.drink = drinkModel
        })
        
        try viewContext.save()
    }
    
    class func deleteDrink(id: String) throws {
        let fetchRequest: NSFetchRequest<DrinkModel> = DrinkModel.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        if let result = try? viewContext.fetch(fetchRequest) {
            result.forEach { drink in
                viewContext.delete(drink)
            }
            try viewContext.save()
        }
    }
}
