//
//  Weather.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 27/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import ObjectMapper

public class Weather: Mappable {
    
    var id: Int?
    var main: Main?
    var weather: [WeatherDetails]?
    var sys: Sys?
    var name: String?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        self.id <- map["id"]
        self.main <- map["main"]
        self.weather <- map["weather"]
        self.sys <- map["sys"]
        self.name <- map["name"]
    }
}
