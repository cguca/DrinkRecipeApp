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
}
