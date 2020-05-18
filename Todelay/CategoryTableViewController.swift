//
//  CategoryTableViewController.swift
//  Todelay
//
//  Created by Hady on 5/9/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var category : Results<Category>?
    
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategoty()
        
    }
    //MARK: - TableView Data source method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell" ,for: indexPath)
       
        cell.textLabel?.text = category?[indexPath.row].name ?? "no Categories add here"
        
        return cell
    }
    
    
    //MARK: - TableView delegate method

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue : UIStoryboardSegue , sender : Any?){
            let destinationVC = segue.destination as! TodoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = category?[indexPath.row]
                
            }
        }
    
    
    
    //MARK: - Add new Category


    @IBAction func addCategory(_ sender: Any) {
        var textFieldDelegate = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
            let newCategory = Category()
            
            newCategory.name = textFieldDelegate.text!
            
            
            self.save(category: newCategory)
            self.tableView.reloadData()
            
        }
        
      alert.addTextField { (alertTextfield) in
        
        alertTextfield.placeholder = "New Category"
        textFieldDelegate = alertTextfield
        
        }
        alert.addAction(action)
        present(alert , animated: true , completion: nil)
    }
    //MARK: - Data manipulation method
    
    func save(category : Category){
       
        do{
           try realm.write {
                realm.add(category)
            }
        }catch {
            print("error in saving category \(error)")
        }
        
    }
    func loadCategoty(){
         category = realm.objects(Category.self)
        }
    }
