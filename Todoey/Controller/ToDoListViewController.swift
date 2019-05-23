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
    
    
    //(1- presist data ) :
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
       
        //( 3- presist data)

        
        loadItems()
        
        
        
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
        
        saveItems()
        
        
        
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
            
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Creat New Item"
          
            textField = alertTextField
          
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK - Manupulation Method
    
    func saveItems() {
        
        
        let encoder = PropertyListEncoder() //( 2- presist data)
        
        
        do{
            let data =  try encoder.encode(itemArray) //(3-presist data)
            try data.write(to: dataFilePath!)
            
        }
        catch{
            
            print("error")
        }
        
        
        tableView.reloadData()
        
        
    }
    
  
    
    func loadItems() {
        
        
        if let data:Data = try? Data(contentsOf: dataFilePath!) {
            
            
            
            let decoder = PropertyListDecoder()
            
            
            do{
            
                itemArray = try! decoder.decode([Item].self, from: data)
            
            }
            
            catch
            {
                
               print ("error decoding,\(error)")
                
            }
        }
        
        
    }
    
   
    
    
    
    
}

