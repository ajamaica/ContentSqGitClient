//
//  User.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 23/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import Foundation
import Mapper

struct User: Mappable {
    
    let login: String
    let id: Int
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try login = map.from("login")
    }
}
