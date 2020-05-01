//
//  ViewController.swift
//  Todelay
//
//  Created by Hady on 4/29/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = ["Angela Yu Course" , "Learn How To learn Udemy" ,"cell3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else
        {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (Action) in
            print("Success")
            if  textField.text != nil {
            self.itemArray.append(textField.text!)
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

