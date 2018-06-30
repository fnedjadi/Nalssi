//
//  BusinessManager.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 27/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import Alamofire

class BusinessManager {
    static func getWeather(id: Int, completed: @escaping ((_ response:Weather?, _ error:Error?) -> Void)) {
        DataAccess.getWeather(id: id) { (res, error) in
            completed(res, error)
        }
    }
    
    static func getDailyWeather(id: Int, completed: @escaping ((_ response:Daily?, _ error:Error?) -> Void)) {
        DataAccess.getDailyWeather(id: id) { (res, error) in
            completed(res, error)
        }
    }
    
    
    static func getUvi(coord: Coord, completed: @escaping ((_ response:Uvi?, _ error:Error?) -> Void)) {
        DataAccess.getUvi(coord: coord) { (res, error) in
            completed(res, error)
        }
    }
    
    static func getUviDaily(coord: Coord, completed: @escaping ((_ response:[Uvi]?, _ error:Error?) -> Void)) {
        DataAccess.getUviDaily(coord: coord) { (res, error) in
            completed(res, error)
        }
    }
    
    static func getCitiesAsync(completed: @escaping (_ cities: [City]?) -> Void) {
        CityDataAccess.loadDataAsync() {
            (cities) in
            if var cities = cities {
                cities.sort { (city1, city2) in (city1.name < city2.name && city1.name >= "A")
                                             || (city1.name == city2.name && city1.country < city2.country)
                                             || (city1.name == city2.name && city1.country == city2.country && city1.id < city2.id)}
                completed(cities)
            }
            else {
                completed(cities)
            }
        }
    }
}
