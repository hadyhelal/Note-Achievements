//
//  Item.swift
//  Todelay
//
//  Created by Hady on 5/14/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
