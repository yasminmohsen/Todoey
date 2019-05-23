//
//  ViewController.swift
//  Todoey
//
//  Created by yasmin mohsen on 5/21/19.
//  Copyright © 2019 yasmin mohsen. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
 var itemArray = [Item]()
    
    let defaults = UserDefaults.standard //(1- presist data )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let newItem = Item()
        newItem.title = "find mike"
        itemArray.append(newItem)
        
        
        
        let newItem2 = Item()
        newItem2.title = "buy eggs"
        itemArray.append(newItem2)
        
        
        let newItem3 = Item()
        newItem3.title = "go home"
        itemArray.append(newItem3)
        
        
        //( 3- presist data)
if let  items = defaults.array(forKey: "ToDoListArray") as? [Item]  {
            
            itemArray = items
        
        
        }
        
        
        
        
    }

   //1-MARK - table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let myItem = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = myItem.title
        
        
        //Ternary operator :
        
        // value = condition ? valueTrue : valuseFlase
        
        
        
        cell.accessoryType = myItem.Done==true ?.checkmark:.none
        
        
        
//        if myItem.Done == true {
//
//            cell.accessoryType = .checkmark
//        }
//        else {
//
//            cell.accessoryType = .none
//        }
//
        return cell
    }
    
    
    
    //2-MARK - Table View Delegate Method (بيأكد ان المربع الي اخترته هو ده الصحيح او الي هعمل عليه الشغل بتاعي )
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       // print(itemArray[indexPath.row])
        
        // to add check squre :
        
        // to deslect if we check twice on the same cell :
        
        
        
    itemArray[indexPath.row].Done = !itemArray[indexPath.row].Done
        
        
        
//        if itemArray[indexPath.row].Done == false {
//
//            itemArray[indexPath.row].Done = true
//
//        }
//
//        else {
//
//            itemArray[indexPath.row].Done = false
//        }
//
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//
//
//        else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
//
        
        
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true) // to make the ui more beutifull
        
        
        
        
        
    }
 
    //3-MARK - : Add new items :
    
    
    @IBAction func addButtonPRESSED(_ sender: UIBarButtonItem){
        
        var textField = UITextField()
        
        
    let alert = UIAlertController(title: "Add New Todoey Item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen when the user clicks the add item alert on our uialert
            
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray") //( 2- presist data)
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Creat New Item"
          
            textField = alertTextField
          
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

