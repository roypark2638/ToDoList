// Make as MVC
// Move data init to model
// user defaults

import UIKit

class TableViewController: UITableViewController {

    var itemList = [Item]()
    let cellIdentifier = "ToDoList"
    let newItemKey = "newItemKey"
    
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var item = Item()
        item.title = "First"
        itemList.append(item)
        
        item.title = "Second"
        itemList.append(item)
        
        item.title = "Third"
        itemList.append(item)
        
        if let safeDefaults = defaults.dictionary(forKey: newItemKey) as? Item {
            itemList.append(safeDefaults)
        }
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
        var textField = UITextField()
        let alert = UIAlertController(title: "ADD NEW ITEM", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "ADD", style: .default) { (action) in
            if let newItemText = textField.text {
                var item = Item()
                item.title = newItemText
                self.itemList.append(item)
                self.defaults.set(item, forKey: self.newItemKey)
                
                self.tableView.reloadData()
            }
            
            
            self.dismiss(animated: true, completion: nil)
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
        print("callForRow is called")
        cell.accessoryType = selectedItem.mark ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        var selectedItem = itemList[indexPath.row]
//        selectedItem.mark = !selectedItem.mark
        itemList[indexPath.row].mark = !itemList[indexPath.row].mark
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
}
