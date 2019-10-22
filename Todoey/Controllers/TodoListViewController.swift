//
//  ViewController.swift
//  Todoey
//
//  Created by Moustafa on 10/16/19.
//  Copyright © 2019 Moustafa. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController  {
    
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //user Defults

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        print(dataFilePath)
        
        // loead table View from UserDefult
//        if let items = defults.array(forKey: "TodoListArray") as? [Item]{
//
//            itemArray = items
//        }
        loaditems()
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.titel
        
        cell.accessoryType = item.done  ? .checkmark : .none
        
        //item.done == true ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Number OF Item IS \(itemArray.count)")
        return itemArray.count
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
       
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    //MARK -- Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textadded = UITextField()

        // create Alert
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // create Action
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen once the user clicks the add item button on our UIAlert
            let newItem = Item()
            newItem.titel = textadded.text!
            
            print("Success")
            print(newItem.titel)
            
            self.itemArray.append(newItem)
            
            // save updated Array at User Defults
            //self.defults.setValue(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
           
        }
        alert.addTextField { (aleartTextField) in
            aleartTextField.placeholder = "Create a New Item"
            
            textadded = aleartTextField
            
        }
        // add Action
        alert.addAction(action)
        
        present(alert, animated: true , completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array , \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loaditems(){
        if let data = try?  Data(contentsOf: dataFilePath! ){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try  decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array , \(error)")
            }
        }
    }
    
}


