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
//    let defaults = UserDefaults.standard
  let dataFileBath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        
//              if let items = defaults.array(forKey: "TO-DO object Added") as? [Item]{
//               itemArray = items
//               }
        loadItem()
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
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (Action) in
            if  textField.text != nil {
           let newItem = Item()
                
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
                
               // self.defaults.set(self.itemArray, forKey: "TO-DO object Added")
                
                self.saveItem()
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
func saveItem (){
        let encoder = PropertyListEncoder()
                       do {
                           let data = try encoder.encode(itemArray) // encode itemArray
                           try  data.write(to:dataFileBath!) // add item to included the file bath
                       } catch
                       {
                           print("here is the Error \(error)")
                       }
    
    self.tableView.reloadData()
    }
    func loadItem() {
        if let data = try? Data(contentsOf: dataFileBath!){
            let decoder = PropertyListDecoder() // here we create an object of this list class
            do {
                itemArray =  try decoder.decode([Item].self, from: data)
            }
            catch {
                print("error here \(error)")
            }
            
        }
        
    }

}

