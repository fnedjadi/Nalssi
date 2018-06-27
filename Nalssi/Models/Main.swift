//
//  Main.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 27/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import ObjectMapper

public class Main: Mappable {
    
    var temp: Double?
    var pressure: Int?
    var humidity: Int?
    var temp_min: Double?
    var temp_max: Double?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        self.temp <- map["temp"]
        self.pressure <- map["pressure"]
        self.humidity <- map["humidity"]
        self.temp_min <- map["temp_min"]
        self.temp_max <- map["temp_max"]
    }
}
