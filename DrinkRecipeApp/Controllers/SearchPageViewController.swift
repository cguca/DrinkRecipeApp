//
//  SearchPageViewController.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 5/31/21.
//

import UIKit

class SearchPageViewController: UIViewController {

    var drinks = [Drink]()
    var selectedIndex = 0
    var currentSearchTask: URLSessionTask?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! DrinkDetailViewController
            detailVC.drink = drinks[selectedIndex]
        }
    }
}

extension SearchPageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentSearchTask?.cancel()
        currentSearchTask = CocktailAPIService.search(type: "s", query: searchText) { (drinks, error) in
            self.drinks = drinks
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

extension SearchPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkSearchCell")!
        
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
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
