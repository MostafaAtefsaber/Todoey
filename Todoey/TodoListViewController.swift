//
//  ViewController.swift
//  Todoey
//
//  Created by Moustafa on 10/16/19.
//  Copyright © 2019 Moustafa. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController  {
    
    
    var itemArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType) == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }
    
    //MARK -- Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textadded = UITextField()

        // create Alert
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // create Action
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen once the user clicks the add item button on our UIAlert
            print(textadded.text!)
            
            print("Success")
            
            self.itemArray.append(textadded.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (aleartTextField) in
            aleartTextField.placeholder = "Create a New Item"
            
            textadded = aleartTextField
            
        }
        // add Action
        alert.addAction(action)
        
        present(alert, animated: true , completion: nil)
    }
    
    
}


