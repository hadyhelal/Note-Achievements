//
//  ViewController.swift
//  Todelay
//
//  Created by Hady on 4/29/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {
    //var itemArray = ["Angela Yu Course" , "Learn How To learn Udemy" ,"cell3"]
    var itemArray = [Item] ()
    
    var selectedCategory : CategoryList? {
        didSet{
            loadItem()
            print("selected category hvae been changed")
        }
    }
    
//    let defaults = UserDefaults.standard
  let dataFileBath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.plist")
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
//              if let items = defaults.array(forKey: "TO-DO object Added") as? [Item]{
//               itemArray = items
//               }

        print(FileManager.default.urls(for: .documentationDirectory, in: .userDomainMask))
    
    }
       
    
    
    //MARK: - TableView Data Source Method
    
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

    
    
    //MARK: - AddButtonPressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (Action) in
            if  textField.text != nil {
              
                let newItem = Item(context: self.context)
                
                newItem.title = textField.text!
                newItem.done = false
                newItem.parentCategory = self.selectedCategory
               
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
    
    
    //MARK: - Data Manipulation Method
    
    func saveItem (){
           do{
           try context.save()
            } catch
           { print(error)
            }
    
    self.tableView.reloadData()
    
    }
    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest() , predicate: NSPredicate? = nil) {
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
    if let additionalPredicate = predicate {
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate , additionalPredicate])
    } else
    {
        request.predicate = categoryPredicate
    }
    
    
        do {
            itemArray = try context.fetch(request)
        }catch{
            print("Error while fetching data \(error)")
        }
        tableView.reloadData()
        }
    
    func deleteItem(indexPath : Int){
        itemArray.remove(at: indexPath)//removing from the array
        context.delete(itemArray[indexPath])// removing from permanent storage
    }
        
    
}

    //MARK: - extension
extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)  // here we  predicate(query) our search and add this query to the request
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItem(with: request , predicate: predicate )

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
