//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by Roy Park on 12/5/20.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {

    var categoryList = [Category]() // create entity object of Category
    let cellIdentifier = "ToDoList"
    let segueIdentifier = "goToItems"
    // access to the skelton
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    

    //MARK: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = textField.text
            if newCategory != "" { // if it's empty, don't create the new list
                let category = Category(context: self.context)
                category.name = newCategory
                self.categoryList.append(category)
                self.saveCategory()
                self.tableView.reloadData()
            }
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type new category"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = categoryList[indexPath.row].name
        
        return cell
    }
    
        
    //MARK: TableViewDelegate Methods.
    
    // when the cell is clicked, go to next view controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // down cast to have an access to the values from the next controller
        let destinationVC = segue.destination as! ToDoListViewController
        // bring indexPath selected from CategoryViewController to ToDoListViewController
        // give the information of categoryList.
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryList[indexPath.row]
        }
    }
    
    
    //MARK: Model Manupulation Methods.
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving Category context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryList = try context.fetch(request)
        } catch {
            print("Error loading categoryList \(error)")
        }
        
        tableView.reloadData()
    }
}
