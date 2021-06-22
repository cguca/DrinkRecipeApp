//
//  ShoppingListViewController.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/5/21.
//

import UIKit
import CoreData

class ShoppingListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var shoppingList : [ShoppingListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
     }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        getSavedShoppingList()
        tableView.reloadData()
    }
    
    func getSavedShoppingList()  {
        let fetchRequest: NSFetchRequest<ShoppingListModel> = ShoppingListModel.fetchRequest()
        if let result = try? viewContext.fetch(fetchRequest) {
            if result.count > 0 {
                shoppingList = result
                return
            }
        }
    }
    
    func deleteShoppingItem(name: String) {
        let fetchRequest: NSFetchRequest<ShoppingListModel> = ShoppingListModel.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        if let result = try? viewContext.fetch(fetchRequest) {
            result.forEach { drink in
                viewContext.delete(drink)
            }
            try? viewContext.save()
            self.tableView.reloadData()
        }
    }
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row].name
        let image = UIImage(data: shoppingList[indexPath.row].image!)
        cell.imageView?.image = image
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Remove") { [self] (_, indexPath) in
        
            deleteShoppingItem(name:  self.shoppingList[indexPath.row].name!)
            self.shoppingList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        
        return[deleteAction]
    }
}
