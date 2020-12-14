//
//  AddViewController.swift
//  ToDoList
//
//  Created by Roy Park on 12/13/20.
//

import UIKit
import RealmSwift
import ChameleonFramework

class AddViewController: UIViewController {
    
    let realm = try! Realm()
    var imageTitle : String = ""
    var addCategoryCompletion: ((Category) -> Void)?

    @IBOutlet var imageButtons: [UIButton]!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageBoxLayout: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imageTitle = ImageTitles.imageTitleDictionary["bookmark"] ?? ""
        setLayout()
    }
    
    
    func setLayout() {
        textField.layer.cornerRadius = 15
        imageBoxLayout.layer.cornerRadius = 10
        imageBoxLayout.layer.shadowRadius = 3
        imageBoxLayout.layer.shadowColor = #colorLiteral(red: 0.9996569753, green: 0.8575745821, blue: 0.4694965482, alpha: 1)
        imageBoxLayout.layer.shadowOpacity = 1
        imageBoxLayout.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    }
    
    func resetButtonStatus() {
        for button in imageButtons {
            button.isSelected = false
            button.isHighlighted = false
//            button.isEnabled = false
        }
    }
    @IBAction func iconButtonSelected(_ sender: UIButton) {
        
        if let imageNumber = imageButtons.firstIndex(of: sender) {
            resetButtonStatus()
            imageTitle = ImageTitles.imageTitleIndex[imageNumber] ?? ""
            sender.isSelected = true
            sender.isHighlighted = true
            sender.isEnabled = true
            
        }
        
    }
    
    func save(_ category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving Category context \(error)")
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        if textField.text != "" {
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.cellColor = "FFFFFF"
            newCategory.image = imageTitle
            save(newCategory)
            self.dismiss(animated: false, completion: {
                self.addCategoryCompletion?(newCategory)
            })
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
