//
//  Item.swift
//  Todelay
//
//  Created by Hady on 5/3/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import Foundation

class Item : Encodable ,Decodable /*or u can use Codable instead of these two */{
    
    var title : String = ""
    var done : Bool = false
    
    }
