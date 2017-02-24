//
//  Branch.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 24/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import Foundation
import Mapper

struct Branch: Mappable {
    
    let name: String
    let commit: Commit
    
    init(map: Mapper) throws {
        try name = map.from("name")
        try commit = map.from("commit")
    }
}
