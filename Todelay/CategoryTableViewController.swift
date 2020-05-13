//
//  CategoryTableViewController.swift
//  Todelay
//
//  Created by Hady on 5/9/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit
import CoreData
class CategoryTableViewController: UITableViewController {

    var category = [CategoryList]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategoty()
        
    }
    //MARK: - TableView Data source method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell" ,for: indexPath)
       
        cell.textLabel?.text = category[indexPath.row].name
        
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
                destinationVC.selectedCategory = category[indexPath.row]
                
            }
        }
    
    
    
    //MARK: - Add new Category


    @IBAction func addCategory(_ sender: Any) {
        var textFieldDelegate = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
            let categoryA = CategoryList(context: self.context)
            
            categoryA.name = textFieldDelegate.text!
            
            self.category.append(categoryA)
            self.saveCategory()
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
    
    func saveCategory(){
       
        do{    try context.save()
        }catch {
            print("error in saving category \(error)")
        }
        
    }
    func loadCategoty(){
        let request : NSFetchRequest<CategoryList> = CategoryList.fetchRequest()
        do {
           category =  try context.fetch(request)
        }
        catch{
            print("error while catching element from CoreData\(error)")
        }
    }
    
    
}
