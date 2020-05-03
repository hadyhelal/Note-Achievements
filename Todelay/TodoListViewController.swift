//
//  ViewController.swift
//  Todelay
//
//  Created by Hady on 4/29/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //var itemArray = ["Angela Yu Course" , "Learn How To learn Udemy" ,"cell3"]
    var itemArray = [Item] ()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let newItem = Item()
        newItem.title = "Angel Yu course"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Read Books"
        itemArray.append(newItem1)
               
        let newItem2 = Item()
        newItem2.title = "Explore Articles"
        itemArray.append(newItem2)
        
               if let items = defaults.array(forKey: "TO-DO object Added") as? [Item]{
               itemArray = items
                
        }
        }
        // Do any additional setup after loading the view.
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCell")
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = item.title
        if item.done == true
        {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (Action) in
            print("Success")
            if  textField.text != nil {
           let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TO-DO object Added")
            self.tableView.reloadData()
            }
            //print(unKnown!)
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new item!"
         textField = alertTextfield
            //print(alertTextfield.text!)
        }
        
        alert.addAction(action)
        present(alert , animated: true , completion: nil)
    }
}

