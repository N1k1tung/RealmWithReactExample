//
//  Repo.swift
//  reactWithRealm
//
//  Created by Nikita Rodin on 3/3/17.
//  Copyright © 2017 Nikita Rodin. All rights reserved.
//

import Foundation
import RealmSwift

class Repo: Object {

    dynamic var id = 0
    dynamic var full_name = ""
    dynamic var language: String? = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
