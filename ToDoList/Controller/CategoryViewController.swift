//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by Roy Park on 12/5/20.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
//    var addCategoryCompletion: ((Category) -> Void)?
    @IBOutlet weak var cellImageIcon: UIImageView!
    
//    @IBOutlet weak var categoryLabel: UILabel!
    var categoryList: Results<Category>? // create entity object of Category
    let cellIdentifier = "Cell"
    let segueIdentifier = "goToItems"
    // access to the skelton
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    //MARK: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "goToAdd", sender: self)

        let modalViewController = AddViewController()
        modalViewController.addCategoryCompletion = { newCategory in
        }
    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "matchSegue" {
//            let controller = segue.destinationViewController as! ResultViewController
//            controller.match = self.match
//        } else if segue.identifier == "historySegue" {
//            let controller = segue.destinationViewController as! HistoryViewController
//            controller.history = self.history
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAdd" {
        let destinationVC = segue.destination as! AddViewController
            destinationVC.addCategoryCompletion = { newCategory in
                self.save(newCategory)
                self.tableView.reloadData()
            }
        }
        else if segue.identifier == segueIdentifier {
            let destinationVC = segue.destination as! ToDoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categoryList?[indexPath.row]
            }
        }
        
    }
//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//        var textField = UITextField()
//
//        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Add", style: .default) { (action) in
//
//
//            if textField.text! != "" { // if it's empty, don't create the new list
//                let newCategory = Category()
//                newCategory.name = textField.text!
//                newCategory.cellColor = UIColor.randomFlat().hexValue()
//                self.save(newCategory)
//                self.tableView.reloadData()
//            }
//        }
//
//
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Type new category"
//            textField = alertTextField
//        }
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
//
//    }
    
    //MARK: TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SwipeTableViewCell
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! CategoryCell
        if let newCategory = categoryList?[indexPath.row] {
            cell.setCategory(category: newCategory)
//            cell.categoryLabel.text = newCategory.name ?? "No Categories are added yet"
//            cell.textLabel?.text = newCategory.name ?? "No Categories are added yet"
//            cell.backgroundColor = UIColor(hexString: newCategory.cellColor ?? "999999")
        }
//        cell.textLabel?.text = categoryList?[indexPath.row].name ?? "No Categories are added yet"
//        cell.backgroundColor = UIColor(hexString: categoryList?[indexPath.row].cellColor ?? "999999")
//        cell.delegate = self
        return cell
    }
    
        
    //MARK: TableViewDelegate Methods.
    
    // when the cell is clicked, go to next view controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // down cast to have an access to the values from the next controller
//        let destinationVC = segue.destination as! ToDoListViewController
//        // bring indexPath selected from CategoryViewController to ToDoListViewController
//        // give the information of categoryList.
//        if let indexPath = tableView.indexPathForSelectedRow {
//            destinationVC.selectedCategory = categoryList?[indexPath.row]
//        }
//    }
    
    
    
    //MARK: Model Manupulation Methods.
    
    func save(_ category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving Category context \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let selectedCategory = self.categoryList?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(selectedCategory)
                }
            } catch {
                print("Error deleting category \(error)")
            }
        }
    }
    
    func loadCategory() {
        
        categoryList = realm.objects(Category.self)
        tableView.reloadData()
//        with request: NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//            categoryList = try context.fetch(request)
//        } catch {
//            print("Error loading categoryList \(error)")
//        }
//
      
    }
}
 
