//
//  SwipeTableViewController.swift
//  Todelay
//
//  Created by Hady on 5/18/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate{

    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    //MARK: -TableView DataSource
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" ,for: indexPath) as! SwipeTableViewCell
           
           cell.delegate = self
           
        return cell
        }
    
        
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            
        guard orientation == .right else { return nil }
            
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            //Handle action by updating model with deletion
           
            self.updateModel(at: indexPath)
        }
            //customize the action apperance
            deleteAction.image = UIImage(named: "delete-icon")
            return [deleteAction]
        }
        
        
        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var option = SwipeTableOptions()
            option.expansionStyle = .destructive
            return option
        }
    
    func updateModel(at indexpath : IndexPath) {
        //update Your dataModel

        }
}
