//
//  Repository.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 23/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import Foundation
import Mapper

struct Repository: Mappable {
    
    let id: Int
    let url: String
    let name: String
    let full_name: String
    var description : String?
    
    init(map: Mapper) throws {
        
        try id = map.from("id")
        try url = map.from("url")
        try name = map.from("name")
        try full_name = map.from("full_name")
        description = map.optionalFrom("description")

    }
    
}
