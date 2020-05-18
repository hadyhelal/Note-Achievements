//
//  ViewController.swift
//  Todelay
//
//  Created by Hady on 4/29/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    //var itemArray = ["Angela Yu Course" , "Learn How To learn Udemy" ,"cell3"]

    var todoItem : Results<Item>?
    
    let realm = try! Realm()

    var selectedCategory : Category? {
        didSet{
            loadItem()
            print("selected category hvae been changed")
        }
    }
    
//    let defaults = UserDefaults.standard
  let dataFileBath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.plist")
  //  let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
//              if let items = defaults.array(forKey: "TO-DO object Added") as? [Item]{
//               itemArray = items
//               }

        print(FileManager.default.urls(for: .documentationDirectory, in: .userDomainMask))
    
    }
       
    
    
    //MARK: - TableView Data Source Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItem?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCell")
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)

        
        if let item = todoItem?[indexPath.row]{
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text =  "No Item Added Yet"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if let item = todoItem?[indexPath.row] {
            do {
                try realm.write{
                item.done = !item.done
            }
            }
                catch {
                    print("error while updating data \(error)")
                }
        }
            tableView.reloadData()
       
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    //MARK: - AddButtonPressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (Action) in
            if  textField.text != nil {
              
                if let currentCategory = self.selectedCategory {
                    do { try self.realm.write{
                        let newItem = Item()
                        newItem.dateCreated = Date()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                    } catch {
                        print("error while saving item \(error)")
                    }
               
            }
                
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
    
    
    //MARK: - Data Manipulation Method
    
    func loadItem(){
        todoItem = realm.objects(Item.self)
    }

    
}

    //MARK: - extension
extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
    todoItem = todoItem?.filter("title CONTAINS [CD] %@ ", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder() // telling searchBar stop being the first responder
    //Basically go to the background go to the original state you'r in before u were activated
            }


        }
    }
}
