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
     var  arrayItem = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.Plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadItem()
//        if let Items = defaults.array(forKey: "ToDoListArray") as? [Item]{
//            arrayItem = Items
//        }
    }

 //MARK - TableView DataSource Methodes
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
         cell.textLabel?.text = arrayItem[indexPath.row].title
        
        // Make the ChackMark of the selected Item
        if arrayItem[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }else{
             cell.accessoryType = .none
        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methodes
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Check the selction Item
        arrayItem[indexPath.row].done = !arrayItem[indexPath.row].done
        saveDataToList()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add New Items to TableView
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "add new Item", message: " ", preferredStyle: .alert)
        let action = UIAlertAction(title: "addItem", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
                self.arrayItem.append(newItem)
                self.saveDataToList()
        }
        alert.addTextField { (alertTeatField) in
            alertTeatField.placeholder = "Enter new Item"
            textField = alertTeatField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Pushing EncoderData to our List in Array
    func saveDataToList(){
        let encoder = PropertyListEncoder()
        do{
            let data  = try encoder.encode(arrayItem)
            try data.write(to: dataFilePath!)
        }catch{
            print("error:\(error)")
        }
         self.tableView.reloadData()
    }
    //MARK - Pushing EncoderData to our List in Array
    func loadItem(){
        if let data = try? Data(contentsOf: dataFilePath!){
        let decoder = PropertyListDecoder()
        do{
            arrayItem = try decoder.decode([Item].self , from: data)
        }catch{
            print("error:\(error)")
            }
            
        }
        
    }

}

