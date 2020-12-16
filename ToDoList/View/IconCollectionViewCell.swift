//
//  IconCollectionViewCell.swift
//  ToDoList
//
//  Created by Roy Park on 12/15/20.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
//        testImage.addGestureRecognizer(tap)
//        testImage.isUserInteractionEnabled = true
        
    }
    
//    @objc func imageTapped() {
//        self.isSelected = true
//        self.alpha = 0.5
        
//    }

}
