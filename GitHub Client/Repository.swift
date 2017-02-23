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
    let description: String
    let full_name : String
    
    init(map: Mapper) throws {
        
        try id = map.from("id")
        try url = map.from("url")
        try description = map.from("description")
        try full_name = map.from("full_name")


    }
    
}
