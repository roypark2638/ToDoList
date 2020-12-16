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
    
    let edgeInset: CGFloat = 1
    var iconImage = IconImage()
    
//        let iconImages = IconImage()
//        iconImages = (iconImages.etcIcons + iconImages.workIcon + iconImages.trasfortationIcon + iconImages.weatherIcon + iconImages.foodIcons + iconImages.peopleIcon + iconImages.animalIcons + iconImages.dirctionIcons + iconImages.logoIcons + iconImages.serviceIcon + iconImages.sportsIcon )
//        return iconImages
//    }()
    
//    self.etcIcons + self.workIcon + self.trasfortationIcon + self.weatherIcon + self.foodIcons + self.peopleIcon + self.animalIcons + self.dirctionIcons + self.logoIcons + self.serviceIcon + self.sportsIcon
//    var iconImages = iconImage.etcIcons
//    var iconImages = iconImage.etcIcons + iconImage.workIcon + iconImage.trasfortationIcon + iconImage.weatherIcon + iconImage.foodIcons + iconImage.peopleIcon + iconImage.animalIcons + iconImage.dirctionIcons + iconImage.logoIcons + iconImage.serviceIcon + iconImage.sportsIcon
    
    let realm = try! Realm()
    var imageTitle : String = ""
    var addCategoryCompletion: ((Category) -> Void)?

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var imageButtons: [UIButton]!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageBoxLayout: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "IconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IconCollectionViewCell")
        
        imageTitle = ImageTitle.imageTitleDictionary["bookmark"] ?? ""
        setLayout()
        
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    
    @objc func imageTapped() {
//        print(self.imageTitle)
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
            imageTitle = ImageTitle.imageTitleIndex[imageNumber] ?? ""
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

extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(iconImage.iconImages.count)
        return iconImage.iconImages.count
            
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCollectionViewCell", for: indexPath) as! IconCollectionViewCell
        
        cell.addGestureRecognizer(tap)
        cell.isUserInteractionEnabled = true
        cell.testImage.image = UIImage(named: iconImage.iconImages[indexPath.row])
        
        
        return cell
    }

    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 7
        let padding: CGFloat = 6
        let collectionViewWidth: CGFloat = collectionView.frame.width - (padding * (itemsPerRow - 1)) - (edgeInset * 2)
        let widthPerItem: CGFloat = collectionViewWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        imageTitle = iconImage.iconImages[indexPath.row]
        
        
    }
    
}

