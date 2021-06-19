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
//        drinks = []
        selectedIndex = 0
        tabBarController?.tabBar.isHidden = true
    }
    
    func handleCategoriesDrinksResponse(data: [Drink], error: Error?) {
//        print(data)
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
    

}

extension CategoryListingViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       tableView.dequeueReusableCell(withIdentifier: )!
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryDrinksCell", for: indexPath)
        let drink = drinks[indexPath.row]
        
        cell.textLabel?.text = drink.strDrink
        cell.imageView?.image = UIImage(named: "PosterPlaceholder")
        CocktailAPIService.downloadDrinkImage(imagePath: drink.strDrinkThumb!) { (data, error) in
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
            self.selectedRecipe = Recipe(drink: data[0])
            self.performSegue(withIdentifier: "showDetail", sender: nil)
        }
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
