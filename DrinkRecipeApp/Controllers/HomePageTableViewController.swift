//
//  HomePageTableViewController.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 5/31/21.
//

import UIKit

class HomePageTableViewController: UITableViewController {
    
    var drinks: [Drink] = []
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CocktailAPIService.getRandomDrink(completion: handleRandomDrinkResponse(data:error:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func handleRandomDrinkResponse(data: [Drink], error: Error?) {
        print(data)
        drinks.append(contentsOf: data)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomePageTableViewCell.identifier, for: indexPath) 
                
        let drink = drinks[indexPath.row]
                   
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! DrinkDetailViewController
            detailVC.drink = drinks[selectedIndex]
            detailVC.recipe = Recipe(drink: drinks[selectedIndex])
        }
    }
}
