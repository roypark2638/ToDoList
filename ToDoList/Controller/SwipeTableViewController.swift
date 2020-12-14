//
//  SwipeTableViewController.swift
//  ToDoList
//
//  Created by Roy Park on 12/12/20.
//

import UIKit
import SwipeCellKit
class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        
        
    }
    func updateModel(at indexPath: IndexPath) {
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(at: indexPath)
//            if let selectedCategory = self.categoryList?[indexPath.row] {
//                do {
//                    try self.realm.write {
//                        self.realm.delete(selectedCategory)
//                    }
//                } catch {
//                    print("Error deleting the category \(error)")
//                }
//            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "Trash-Icon")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}


