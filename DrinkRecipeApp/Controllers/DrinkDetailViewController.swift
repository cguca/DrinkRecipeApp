//
//  DrinkDetailViewController.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 5/31/21.
//

import UIKit
import CoreData

class DrinkDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var instructionsLabel: UITextView!
    @IBOutlet weak var titleNavigationIten: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var drink: Drink?
    var recipe: Recipe?
    var ingredients : [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ingredients = recipe?.ingredients
//        instructionsLabel.sizeThatFits(CGSize(width: 500, height: 500))
        nameLabel.text = drink?.strDrink
        instructionsLabel.text = drink?.strInstructions
        titleNavigationIten.title = drink?.strDrink
        getImage()
    }
    
    func getImage() {
        CocktailAPIService.downloadDrinkImage(imagePath: (drink?.strDrinkThumb)!) { (data, error) in
            guard let data = data else {
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.drinkImage.image = image
            }
        }
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        let drinkModel = DrinkModel(context: viewContext)
        
//        drinkModel.id = drink?.idDrink
//        drinkModel.alchoholic = drink?.strAlcoholic
//        drinkModel.drinkAlternative = drink?.strDrinkAlternate
//        drinkModel.glass = drink?.strGlass
//        drinkModel.iba = drink?.strIBA
//        drinkModel.instructions = drink?.strInstructions
//        drinkModel.name = drink?.strDrink
//        drinkModel.tags = drink?.strTags
//        drinkModel.thumbImage = drinkImage.image
        
        drinkModel.id = recipe?.id
        drinkModel.alchoholic = recipe?.alcoholic
        drinkModel.drinkAlternative = recipe?.alternate
        drinkModel.glass = recipe?.glass
        drinkModel.iba = recipe?.iba
        drinkModel.instructions = recipe?.instructions
        drinkModel.name = recipe?.name
        drinkModel.tags = recipe?.tags
        
        let ingredients = recipe?.ingredients
        ingredients?.forEach({ (key, value) in
            let ingredientModel = IngredientModel(context: viewContext)
            ingredientModel.name = key
            ingredientModel.measure = value
            ingredientModel.drink = drinkModel
            
        })
        
        do {
            try viewContext.save()
        }  catch {
            print("There was an error while saving the image to core data: \(error.localizedDescription)")
        }
    }
}

extension DrinkDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        (recipe?.ingredients.count)!
        return ingredients!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let ingredients = recipe?.ingredients
//        cell.textLabel?.text = "\(String(describing: ingredients))"
        let key = Array(ingredients!.keys)[indexPath.row]
        cell.textLabel?.text = "\(key) - \(String(describing: ingredients![key]!))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = Array(ingredients!.keys)[indexPath.row]
        
        let shoppingListModel = ShoppingListModel(context: viewContext)
        shoppingListModel.name = key
        do {
            try viewContext.save()
        }  catch {
            print("There was an error while saving the image to core data: \(error.localizedDescription)")
        }
    }
}
