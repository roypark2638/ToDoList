// Make as MVC
// Move data init to model
// user defaults

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemList = [Item]()
    
    var selectedCategory : Category? {
        didSet {
            loadItem()
        }
    }
    let cellIdentifier = "Items"
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            .first?.appendingPathComponent("Items.plist")
//        print(dataFilePath)
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "ADD NEW ITEM", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            if let newItemText = textField.text {
                if newItemText != ""{
                    let item = Item(context: self.context)
                    item.title = newItemText
                    item.mark = false
                    item.parentCategory = self.selectedCategory
                    self.itemList.append(item)
                    
                    self.saveItems()
                }
                
            }
            //            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type new item"
            textField = alertTextField
        }
        
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = itemList[indexPath.row].title
        let selectedItem = itemList[indexPath.row]
        
        // Ternary operator ==>
        // value = condition ? true : false
        cell.accessoryType = selectedItem.mark ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        var selectedItem = itemList[indexPath.row]
        //        selectedItem.mark = !selectedItem.mark
        
        context.delete(itemList[indexPath.row])
        itemList.remove(at: indexPath.row)
        
        //itemList[indexPath.row].setValue("Complted", forKey: "title") // another way to update the NSManageObject
//        itemList[indexPath.row].mark = !itemList[indexPath.row].mark
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK: Model Manupulation Methods.
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    func loadItem(with request: NSFetchRequest<Item> = Item.fetchRequest(), with predicate: NSPredicate? = nil) {
        // most of caess in swift you don't have to specify the type
        // but in this case, you have to. The entity that you are tying to request.
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//            request.predicate = compoundPredicate
        } else {
            request.predicate = categoryPredicate
        }
        
        
        do {
            itemList = try context.fetch(request)
        } catch {
            print("Error fetching data from contest \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
}

//MARK: UISearchBar Methods
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // again request to fetch the data and declare the <type> for NSFetchRequest Class
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        //[cd] is for case insensitive (no lower and upper case)
        // CONTAINS %@ find the string contains the value from searchBar.
        // modify our quary
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@",searchBar.text!)
        
        
        // sort the data and save
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        // and save into the array
//        request.sortDescriptors = [sortDescriptor]
        
        loadItem(with: request, with: predicate)
        
//        do {
//            itemList = try context.fetch(request)
//        } catch {
//            print("Error fetching data from contest \(error)")
//        }
//        // reload the data and update tableview
//        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
