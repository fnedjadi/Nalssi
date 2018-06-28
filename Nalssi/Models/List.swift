//
//  List.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 28/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import ObjectMapper

public class List: Mappable {
    
    var id: Int?
    var weather: [WeatherDetails]?
    var main: Main?
    var date: String?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        self.id <- map["id"]
        self.weather <- map["weather"]
        self.main <- map["main"]
        self.date <- map["dt_txt"]
    }
}
