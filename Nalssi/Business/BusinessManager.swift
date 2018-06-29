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
    
    static func getCitiesAsync(completed: @escaping (_ cities: [City]?) -> Void) {
        CityDataAccess.loadDataAsync(completed: completed)
    }
}
