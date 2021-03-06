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
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recipe: Recipe? 
    var ingredients : [String: String]?
    var isSavedToFavorites: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        ingredients = recipe?.ingredients
        nameLabel.text = recipe?.name
        instructionsLabel.text = recipe?.instructions
        titleNavigationIten.title = recipe?.name
        getImage()
        setFavoriteIcon()
    }
    
    func getImage() {
        if let image = recipe?.image {
            DispatchQueue.main.async {
                self.drinkImage.image = UIImage(data: image)
            }
            return
        }
        
        imageActivityIndicator.isHidden = false
        imageActivityIndicator.startAnimating()
        
        CocktailAPIService.downloadDrinkImage(imagePath: (recipe?.imageUrl)!) { [self] (data, error) in
            guard let data = data else {
                return
            }
            
            
            let image = UIImage(data: data)
            self.recipe?.image = data
            DispatchQueue.main.async {
                self.imageActivityIndicator.isHidden = true
                self.imageActivityIndicator.stopAnimating()
                self.drinkImage.image = image
            }
        }
    }
    
    func setFavoriteIcon() {
        let favorite = CocktailCoreDataService.getSavedFavorite(id: recipe!.id!)
        if favorite != nil {
            let heartfill = UIImage(systemName: "heart.fill")
            navigationItem.rightBarButtonItem?.image = heartfill
            navigationItem.rightBarButtonItem?.tintColor = .red
            isSavedToFavorites = true
        } else {
            let heart = UIImage(systemName: "heart")
            navigationItem.rightBarButtonItem?.image = heart
            navigationItem.rightBarButtonItem?.tintColor = .systemGray
            isSavedToFavorites = false
        }
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        guard recipe != nil else {
            showSaveToFavoritesAlert(message: "Error saving to your favorites")
            return
        }
        if !isSavedToFavorites {
            do {
                try  CocktailCoreDataService.saveToFavorites(recipe: recipe!)
                showSaveToFavoritesAlert(message: "Saved to your favorites")
                let heartfill = UIImage(systemName: "heart.fill")
                navigationItem.rightBarButtonItem?.image = heartfill
                navigationItem.rightBarButtonItem?.tintColor = .red
                isSavedToFavorites = true
            } catch  {
                showSaveToFavoritesAlert(message: "Error saving to your favorites")
            }
        } else if isSavedToFavorites{
            do {
                try CocktailCoreDataService.deleteDrink(id: (recipe?.id)!)
                showSaveToFavoritesAlert(message: "Removed from your favorites")
                let heart = UIImage(systemName: "heart")
                navigationItem.rightBarButtonItem?.image = heart
                navigationItem.rightBarButtonItem?.tintColor = .systemGray
                isSavedToFavorites = false
            } catch  {
                showSaveToFavoritesAlert(message: "Error removing from your favorites")
            }
        }
    }
    
    func showSaveToFavoritesAlert(message: String) {
        let alertVC = UIAlertController(title: "Add to Favorits", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
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
        
        cell.startActivityIndicator()
        CocktailAPIService.downloadIngredientImage(ingredient: key) { (data, error) in
            guard error == nil else {
                self.showApiErrorAlert(message: error?.localizedDescription ?? "Connection Issue. Please restart")
                cell.stopActivityIndicator()
                return
            }
            
            guard let data = data else {
                return
            }
            
            cell.stopActivityIndicator()
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
            showShoppingListAlert(message: "Added to shopping list")
        } else {
            CocktailCoreDataService.deleteShoppingItem(name: key)
            cell?.accessoryView?.tintColor = .systemGray
            showShoppingListAlert(message: "Removed from shopping list")
        }
    }
    
    func showShoppingListAlert(message: String) {
        let alertVC = UIAlertController(title: "Shopping List", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
