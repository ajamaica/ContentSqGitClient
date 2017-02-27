//
//  DetailCommit.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 27/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import Foundation
import Mapper

struct DetailCommit: Mappable {
    
    let message: String

    
    init(map: Mapper) throws {
        try message = map.from("message")

        
    }
}
