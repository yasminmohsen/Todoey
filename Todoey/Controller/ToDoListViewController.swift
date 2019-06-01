//
//  ViewController.swift
//  Todoey
//
//  Created by yasmin mohsen on 5/21/19.
//  Copyright © 2019 yasmin mohsen. All rights reserved.
//

import UIKit
import CoreData //(0- presist data)

class ToDoListViewController: UITableViewController {

    
 var itemArray = [Item]()
    
    var selectedCatego:Category? {
        
        didSet{  // (بنستخدم الطريقة دي معناها لما نضغط عليها الحاجة بتاعتنا تحمل )
            
            loadItems()
            
        }
    }
    
    
    
    
    //(1- presist data ) :
    

         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
   // (بنستورد من الappDelegate الجزء بتاع الpresitent container )
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
      
    
        //( 4- presist data)

        let request : NSFetchRequest<Item> = Item.fetchRequest()
     
        
    }
        
    

    //1-MARK:- - table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let myItem = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = myItem.title
        
        
        //Ternary operator :
        
        // value = condition ? valueTrue : valuseFlase
        
         // to add check squre :
        cell.accessoryType = myItem.done==true ?.checkmark:.none
        
        
        
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
    
    
    
    //2-MARK: - Table View Delegate Method (بيأكد ان المربع الي اخترته هو ده الصحيح او الي هعمل عليه الشغل بتاعي )
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       // print(itemArray[indexPath.row])
        
       
        context.delete(itemArray[indexPath.row]) //(1- delete item)
        
         itemArray.remove(at: indexPath.row) //(2- delete item)
        
        
        // to deslect if we check twice on the same cell :
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        
        
//        if itemArray[indexPath.row].Done == false {
//
//            itemArray[indexPath.row].Done = true
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
//        else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
//
        
        
        tableView.deselectRow(at: indexPath, animated: true) // to make the ui more beutifull
        
        
        
        
        
    }
 
    //3-MARK: - : Add new items :
    
    
    @IBAction func addButtonPRESSED(_ sender: UIBarButtonItem){
        
        var textField = UITextField()
        
        
    let alert = UIAlertController(title: "Add New Todoey Item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen when the user clicks the add item alert on our uialert
            
            
            
            
            let newItem = Item(context:  self.context)   //(2- presist data) (it represents the data in each row of the table)
            newItem.title = textField.text!
            
            newItem.done = false
            
            newItem.parentCategory = self.selectedCatego
            
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
    
    
    //MARK: - Manupulation Method to save and  load the items that saved in the data base
    
    func saveItems() {
        
  
        
        do{
            
            
       

           try context.save()   //(3- presist data )
            
        }
        catch{
            
            print("error saving context \(error)")
        }
        
        
        tableView.reloadData()
        
        
    }
    
    // to load the saved data :
    
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest(),predicate:NSPredicate?=nil) {
        
        
        
        
        let categoryPredeicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCatego!.name!)
        
        
        
        if let additionalPredicate = predicate{
            
          request.predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredeicate,additionalPredicate])
        
        }
        else {
            
            request.predicate=categoryPredeicate
            
        }
        
       // let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates:[categoryPredeicate,predicate!])
        

        do{
        itemArray = try context.fetch(request)
        }
        catch{

            print("error loading item \(error)")
        }

        tableView.reloadData()
        
    }
    
    
        
    }
    
//MARK: - Search bar method)

     // to make a search for an item ! ?
    
              extension ToDoListViewController : UISearchBarDelegate {
    
    
    
                      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
                        let request :NSFetchRequest<Item>=Item.fetchRequest()
                        
                        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
                        
     
                        
                       request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                        
                      
                        loadItems(with: request,predicate: predicate)
                        
                }
                // 1-to return back to the item after doing search :
                
                
                
                
                func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                    
                    if searchBar.text?.count == 0 {
                        
                        loadItems()
                        
                        // 2-the next method is to tell the search bar to stop responding
                        
                        
                        DispatchQueue.main.async {
                            
                                searchBar.resignFirstResponder()
                            
                        }
                            
                    
                        
                    }
                    
                    
                }

                     }
















