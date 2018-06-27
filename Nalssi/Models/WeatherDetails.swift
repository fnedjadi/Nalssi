//
//  WeatherDetails.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 27/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import ObjectMapper

public class WeatherDetails: Mappable {
    
    var id: Int?
    var main: String?
    var description: String?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        self.id <- map["id"]
        self.main <- map["main"]
        self.description <- map["description"]
    }
}

