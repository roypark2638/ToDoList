//
//  Category.swift
//  ToDoList
//
//  Created by Roy Park on 12/11/20.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var cellColor: String = "FFFFFF"
    @objc dynamic var image: String = ""
    let items = List<Item>()
}


