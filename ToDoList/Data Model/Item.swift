//
//  Item.swift
//  ToDoList
//
//  Created by Roy Park on 12/11/20.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var mark: Bool = false
    @objc dynamic var dateCreated: Date?
    
    // You need to put the type fromType:
    // Category is a class and if you want type then Category.self
    // property is we need to specify is what is the name of that forward relationship.
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
