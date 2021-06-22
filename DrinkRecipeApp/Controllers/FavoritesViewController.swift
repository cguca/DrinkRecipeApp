//
//  FavoritesViewController.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/1/21.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var drinks = [DrinkModel]()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DrinklTableViewCell.nib(), forCellReuseIdentifier: DrinklTableViewCell.identifier)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        drinks = CocktailCoreDataService.getSavedFavorites()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! DrinkDetailViewController
            detailVC.recipe = Recipe(drinkModel: drinks[selectedIndex])
        }
    }
    
    func showDeleteFavoriteAlert(message: String) {
        let alertVC = UIAlertController(title: "Favorites", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinklTableViewCell.identifier, for: indexPath) as! DrinklTableViewCell
        
        let drinkImage = UIImage(data: drinks[indexPath.row].thumbImage!)
        cell.drinkImageView.image = drinkImage
        cell.catgoryLabel.text = drinks[indexPath.row].category
        cell.nameLabel.text = drinks[indexPath.row].name
        cell.glassLabel.text = drinks[indexPath.row].glass
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Remove") { (_, indexPath) in
            print("Removed from favorites")
            
            do {
                try CocktailCoreDataService.deleteDrink(id: self.drinks[indexPath.row].id!)
                self.drinks.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            } catch {
                self.showDeleteFavoriteAlert(message: "Error removing drink from favorites")
            }
        }
        
        return[deleteAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
