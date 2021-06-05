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

    var shoppingList : [ShoppingListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getSavedShoppingList()
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
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = shoppingList?[indexPath.row].name
        return cell
    }
    
    
}
