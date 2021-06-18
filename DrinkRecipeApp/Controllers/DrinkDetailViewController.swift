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
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var titleNavigationIten: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recipe: Recipe? 
     var ingredients : [String: String]?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
//        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        ingredients = recipe?.ingredients
        nameLabel.text = recipe?.name
        instructionsLabel.text = recipe?.instructions
        titleNavigationIten.title = recipe?.name
        getImage()
    }
    
    func getImage() {
        if let image = recipe?.image {
            DispatchQueue.main.async {
                self.drinkImage.image = UIImage(data: image)
            }
            return
        }
        
        CocktailAPIService.downloadDrinkImage(imagePath: (recipe?.imageUrl)!) { (data, error) in
            guard let data = data else {
                return
            }
            let image = UIImage(data: data)
            self.recipe?.image = data
            DispatchQueue.main.async {
                self.drinkImage.image = image
            }
        }
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        let drinkModel = DrinkModel(context: viewContext)
        drinkModel.id = recipe?.id
        drinkModel.alchoholic = recipe?.alcoholic
        drinkModel.drinkAlternative = recipe?.alternate
        drinkModel.glass = recipe?.glass
        drinkModel.iba = recipe?.iba
        drinkModel.instructions = recipe?.instructions
        drinkModel.name = recipe?.name
        drinkModel.tags = recipe?.tags
        drinkModel.thumbImage = recipe?.image
        
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
        print("The nummber of ingredients is \(ingredients!.count)")
        return ingredients!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.identifier, for: indexPath) as! IngredientTableViewCell

        let key = Array(ingredients!.keys)[indexPath.row]
       
        cell.accessoryView =  UIImageView(image: UIImage(systemName: "cart"))
        
        if let _ = CocktailCoreDataService.getShoppingListItem(name: key) {
            cell.accessoryView?.tintColor = .systemGreen
        } else {
            cell.accessoryView?.tintColor = .systemGray
        }
       
        cell.configure(label: "\(key) - \(String(describing: ingredients![key]!))")
   
        cell.imageView?.image = UIImage(named: "placeholder")
        CocktailAPIService.downloadIngredientImage(ingredient: key) { (data, error) in
            guard let data = data else {
                return
            }
            
            let image = UIImage(data: data)
            cell.imageView?.image = image
            cell.setNeedsLayout()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = Array(ingredients!.keys)[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        let imageData = cell?.imageView?.image?.pngData()
        
        let shoppingListItem = CocktailCoreDataService.getShoppingListItem(name: key)
        
        if shoppingListItem == nil {
            CocktailCoreDataService.saveShoppingListItem(name: key, imageData: imageData!)
            cell?.accessoryView?.tintColor = .systemGreen
        } else {
            CocktailCoreDataService.deleteShoppingItem(name: key)
            cell?.accessoryView?.tintColor = .systemGray
        }
    }
}
