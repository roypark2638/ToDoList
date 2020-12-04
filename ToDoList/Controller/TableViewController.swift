// Make as MVC
// Move data init to model
// user defaults

import UIKit

class TableViewController: UITableViewController {
    
    var itemList = [Item]()
    let cellIdentifier = "ToDoList"
    let newItemKey = "newItemKey"
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        .first?.appendingPathComponent("Items.plist")
    
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
        
        loadItem()
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "ADD NEW ITEM", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "ADD", style: .default) { (action) in
            if let newItemText = textField.text {
                var item = Item()
                item.title = newItemText
                self.itemList.append(item)
                
                self.saveItems()
                
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
        itemList[indexPath.row].mark = !itemList[indexPath.row].mark
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK: Model Manupulation Methods.
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemList)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item list, \(error)")
        }
        
        self.tableView.reloadData()
    }
    func loadItem() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemList = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item list, \(error)")
            }
        }
    }
}
