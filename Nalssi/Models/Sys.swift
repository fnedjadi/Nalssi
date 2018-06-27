//
//  Sys.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 27/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import ObjectMapper

public class Sys: Mappable {
    
    var id: Int?
    var country: String?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        self.id <- map["id"]
        self.country <- map["country"]
    }
}
