//
//  Issue.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 27/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import Foundation
import Mapper

struct Issue: Mappable {
    
    let title: String
    let body: String

    let user: User
    
    init(map: Mapper) throws {
        try title = map.from("title")
        try body = map.from("body")
        try user = map.from("user")
        
    }
}
