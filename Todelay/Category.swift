//
//  Category.swift
//  Todelay
//
//  Created by Hady on 5/14/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
