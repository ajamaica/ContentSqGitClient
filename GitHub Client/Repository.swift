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
    let owner: User
    var forks: Int?
    var forks_count: Int?
    var stargazers_count: Int?
    
    init(map: Mapper) throws {
        
        try id = map.from("id")
        try url = map.from("url")
        try name = map.from("name")
        try full_name = map.from("full_name")
        try owner = map.from("owner")
        description = map.optionalFrom("description")
        forks = map.optionalFrom("forks")
        forks_count = map.optionalFrom("forks_count")
        stargazers_count = map.optionalFrom("stargazers_count")

    }
    
}
