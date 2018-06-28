//
//  City.swift
//  Nalssi
//
//  Created by Corentin Redon on 6/28/18.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation

public class City: Decodable {
    
    var id: Int
    var name: String
    var country: String
    var coord: Coord
    
    public init(id: Int, name: String, country: String, coord: Coord) {
        self.id = id
        self.name = name
        self.country = country
        self.coord = coord
    }
}
