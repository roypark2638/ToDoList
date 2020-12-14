//
//  CategoryCell.swift
//  ToDoList
//
//  Created by Roy Park on 12/13/20.
//


import UIKit
import SwipeCellKit

class CategoryCell: SwipeTableViewCell {
        
    @IBOutlet weak var cellImageIcon: UIImageView!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    func setCategory(category: Category) {
        
        cellImageIcon.image = UIImage(named: category.image)
        cellTextLabel.text = category.name        
    }
}
