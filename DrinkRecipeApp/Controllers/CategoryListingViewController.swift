//
//  CategoryListingViewController.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/18/21.
//

import UIKit

class CategoryListingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var drinks = [Drink]()
    var selectedIndex = 0
    var category: Recipe?
    var selectedRecipe : Recipe?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tabBarController?.tabBar.isHidden = true
        CocktailAPIService.filter(type: "c", query: (category?.category)!, completion: handleCategoriesDrinksResponse(data:error:))
        navigationItem.title = (category?.category)!
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 0
        tabBarController?.tabBar.isHidden = true
    }
    
    func handleCategoriesDrinksResponse(data: [Drink], error: Error?) {
        guard error == nil else {
            self.showApiErrorAlert(message: error?.localizedDescription ?? "Connection Issue. Please restart")
            return
        }
        
        drinks = []
        drinks.append(contentsOf: data)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! DrinkDetailViewController
            
            detailVC.recipe = selectedRecipe
        }
    }
    
//    func showApiErrorAlert(message: String) {
//        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .actionSheet)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alertVC, animated: true, completion: nil)
//    }

}

extension CategoryListingViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryDrinksCell", for: indexPath)
        let drink = drinks[indexPath.row]
        
        cell.textLabel?.text = drink.strDrink
        cell.imageView?.image = UIImage(named: "placeholder")
        
        CocktailAPIService.downloadDrinkImage(imagePath: drink.strDrinkThumb!) { (data, error) in
            guard error == nil else {
                self.showApiErrorAlert(message: error?.localizedDescription ?? "Connection Issue. Please restart")
                return
            }
            
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
        selectedIndex = indexPath.row
        CocktailAPIService.lookup(type: "i", query: drinks[selectedIndex].idDrink!) {(data, error) in
            guard error == nil else {
                self.showApiErrorAlert(message: error?.localizedDescription ?? "Connection Issue. Please restart")
                return
            }
            self.selectedRecipe = Recipe(drink: data[0])
            self.performSegue(withIdentifier: "showDetail", sender: nil)
        }
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
