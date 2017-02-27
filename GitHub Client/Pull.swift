//
//  Pull.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 27/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import Foundation
import Mapper

struct Pull: Mappable {
    
    let title: String
    let user: User
    let body: String
    
    init(map: Mapper) throws {
        try title = map.from("title")
        try user = map.from("user")
        try body = map.from("body")
        
    }
}
