//
//  ViewController.swift
//  Todoey
//
//  Created by yasmin mohsen on 5/21/19.
//  Copyright © 2019 yasmin mohsen. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    let itemArray = ["Find Mike","Buy Eggos" , "Destroy Demogorgon"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   //1-MARK - table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    
    //2-MARK - Table View Delegate Method (بيأكد ان المربع الي اخترته هو ده الصحيح او الي هعمل عليه الشغل بتاعي )
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print(itemArray[indexPath.row])
        
        // to add check squre :
        
        // to deslect if we check twice on the same cell :
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
            
        
        else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
            
        
        tableView.deselectRow(at: indexPath, animated: true) // to make the ui more beutifull
        
        
        
        
        
    }
    
}

