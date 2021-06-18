//
//  HomePageTableViewController.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 5/31/21.
//

import UIKit

class HomePageTableViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var drinks: [Drink] = []
    var categories: [Drink] = []
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.register(HomePageTableViewCell.nib(), forCellReuseIdentifier: HomePageTableViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView.collectionViewLayout = layout
        collectionView.register(HomePageCollectionViewCell.nib(), forCellWithReuseIdentifier: "HomePageCollectionViewCell")
        
        tabBarController?.tabBar.isHidden = false
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        CocktailAPIService.getRandomDrink(completion: handleRandomDrinkResponse(data:error:))
        CocktailAPIService.list(type: "c", query: "list", completion: handleListCategoriesResponse(data:error:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    func handleRandomDrinkResponse(data: [Drink], error: Error?) {
        print(data)
        drinks.append(contentsOf: data)
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func handleListCategoriesResponse(data: [Drink], error: Error?) {

        categories.append(contentsOf: data)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! DrinkDetailViewController
//            detailVC.drink = drinks[selectedIndex]
            detailVC.recipe = Recipe(drink: drinks[selectedIndex])
        }
        if segue.identifier == "showListing" {
            let detailVC = segue.destination as! CategoryListingViewController
//            detailVC.drink = drinks[selectedIndex]
            let selectedCategory = Recipe(drink:categories[selectedIndex])
            detailVC.category = selectedCategory
        }
    }
}

extension HomePageTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinks.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomePageTableViewCell.identifier, for: indexPath) as! HomePageTableViewCell
        let drink = drinks[indexPath.row]
//        let imagePath =  drink.strDrinkThumb!
        
        guard drink.strDrinkThumb != nil else {
            let image = UIImage(named: "placeholder")
            cell.drinkImageView?.image = image
//            cell.configure(with: image!)
            cell.setNeedsLayout()
            return cell
        }
        CocktailAPIService.downloadDrinkImage(imagePath: drink.strDrinkThumb!) { [self] (data, error) in
            guard let data = data else {
                return
            }
       
            let image = UIImage(data: data)
//            cell.imageView?.image = image
            cell.configure(with: image!, name: self.drinks[indexPath.row].strDrink!)
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

// Mark - Collection View
extension HomePageTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedIndex = indexPath.row
//        let category = categories[selectedIndex]
        performSegue(withIdentifier: "showListing", sender: nil)
       
        
        //execute seque
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionViewCell", for: indexPath) as! HomePageCollectionViewCell
        
        let category = categories[indexPath.row]
        let name = category.strCategory
        cell.configure(with: UIImage(named: "placeholder")!, name: name!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
}
