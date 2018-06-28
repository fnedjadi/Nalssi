//
//  Daily.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 28/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import ObjectMapper

public class Daily: Mappable {
    
    var id: Int?
    var city: City?
    var cnt: Int?
    var list: [List]?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        self.id <- map["id"]
        self.city <- map["city"]
        self.cnt <- map["cnt"]
        self.list <- map["list"]
    }
}
