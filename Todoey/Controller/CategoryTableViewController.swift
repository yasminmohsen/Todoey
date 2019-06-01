//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by yasmin mohsen on 5/31/19.
//  Copyright © 2019 yasmin mohsen. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

   var catogarray=[Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadCatego()
        
    }
    
    
    
    
    
     //MARK: - 1-TableView Data Source Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catogarray.count
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        cell.textLabel?.text = catogarray[indexPath.row].name
        
        
        
        return cell
        
    }
    
    
    
    
    
    
    
    
    
    
     //MARK: - 3-Data Manipulation Methods
    
    
    
    
    func saveCatego() {
        
        
        
        
        do{
            
            
            
            
            try context.save()   //(3- presist data )
            
        }
        catch{
            
            print("error saving context \(error)")
        }
        
        
        tableView.reloadData()
        
        
    }
    
    // to load the saved data :
    
    func loadCatego(){
        
        let request : NSFetchRequest<Category>=Category.fetchRequest()
        
        do{
        catogarray = try context.fetch(request)
        
        }
        
        catch{
            
            print("error loading data \(error)")
        }
        
        
        tableView.reloadData()
    }

    
    
    
    
    
    
    
    
   
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem)
    
     //MARK: -2-Add New Categories
    
    
    {
        var textfield = UITextField()
        
        
        let alert = UIAlertController (title: "Add new category", message: " ", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
         let newCatego = Category(context: self.context)
           
            newCatego.name = textfield.text
             self.catogarray.append(newCatego)
            
            self.saveCatego()
            
            
        }
        
       
        
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            
            textfield = field
            textfield.placeholder = "Add A New Category"
            
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    
   
    
    
    
    //MARK: - 4-TableView Delegate Methods
    //(لما اضغط على اي  category بياخدني للعناصر الي تحت الcategory الي ضغطت عليه )
   
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! ToDoListViewController
        
        
        if   let indexpath = tableView.indexPathForSelectedRow{
            
            
          destination.selectedCatego = catogarray[indexpath.row]
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
