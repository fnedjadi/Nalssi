//
//  CityWeather.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 28/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import ObjectMapper

public class CityWeather: Mappable {

    var id: Int?
    var name: String?
    var country: String?

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.country <- map["country"]
    }
}
