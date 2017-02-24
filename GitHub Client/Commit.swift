//
//  Commit.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 24/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import Foundation
import Mapper

struct Commit: Mappable {
    
    let sha: String
    let url: String
    
    init(map: Mapper) throws {
        try sha = map.from("sha")
        try url = map.from("url")

    }
}
