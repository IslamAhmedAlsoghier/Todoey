//
//  ViewController.swift
//  Todoey
//
//  Created by Islam ahmedd on 5/23/19.
//  Copyright © 2019 Islam ahmed. All rights reserved.
//

import UIKit

class ToDoListViewContrller: UITableViewController {

    //Declare Instance here
    var  arrayItem = ["Cell1","Cell2","Cell3"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

 //MARK - TableView DataSource Methodes
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    cell.textLabel?.text = arrayItem[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate Methodes
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add New Items to TableView
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "add new Item", message: " ", preferredStyle: .alert)
        let action = UIAlertAction(title: "addItem", style: .default) { (action) in
                self.arrayItem.append(textField.text!)
                self.tableView.reloadData()
        }
        alert.addTextField { (alertTeatField) in
            alertTeatField.placeholder = "Enter new Item"
            textField = alertTeatField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

