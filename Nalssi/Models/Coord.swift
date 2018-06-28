//
//  Coord.swift
//  Nalssi
//
//  Created by Corentin Redon on 6/28/18.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation

public class Coord: Decodable {
    
    var lon: Double
    var lat: Double
    
    public init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}
