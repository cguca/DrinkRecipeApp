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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getSavedFavorites()
        // Do any additional setup after loading the view.
    }

    func getSavedFavorites() {
        let fetchRequest: NSFetchRequest<DrinkModel> = DrinkModel.fetchRequest()
    //    let predicate = NSPredicate(format: "pin == %@", pin)
    //    fetchRequest.predicate = predicate
        if let result = try? viewContext.fetch(fetchRequest) {
            if result.count > 0 {
                drinks.append(contentsOf: result)
    //            images = PhotoAdapter.adapt(photos: result)
    //            newCollectionButton.isEnabled = true
                return
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.imageView?.image = UIImage(data: drinks[indexPath.row].thumbImage!)
        cell.textLabel?.text = drinks[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Remove") { (_, indexPath) in
            print("Removed from favorites")
            self.drinks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return[deleteAction]
    }
}
