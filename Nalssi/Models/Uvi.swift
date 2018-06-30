//
//  Uvi.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 30/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import ObjectMapper

public class Uvi: Mappable {
    
    var date_iso: String?
    var date: Int?
    var value: Double?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        self.date_iso <- map["date_iso"]
        self.date <- map["date"]
        self.value <- map["value"]
    }
}
