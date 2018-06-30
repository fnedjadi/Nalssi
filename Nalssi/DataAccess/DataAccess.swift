//
//  DataAccess.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 27/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class DataAccess {
    static func getWeather(id: Int, completed: @escaping ((_ response:Weather?, _ error:Error?) -> Void)) {
        let params = ["id": "\(id)",
            "units": "metric",
            "appid": Constants.Headers.Api_Key]
        
        Alamofire.request(Router.getWeather().path, method: Router.getWeather().method, parameters: params, encoding: URLEncoding.queryString, headers: [:])
            .validate()
            .responseObject { (alamoResponse: DataResponse<Weather>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func getDailyWeather(id: Int, completed: @escaping ((_ response:Daily?, _ error:Error?) -> Void)) {
        let params = ["id": "\(id)",
            "units": "metric",
            "appid": Constants.Headers.Api_Key]
        
        Alamofire.request(Router.getDaily().path, method: Router.getDaily().method, parameters: params, encoding: URLEncoding.queryString, headers: [:])
            .validate()
            .responseObject { (alamoResponse: DataResponse<Daily>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func getUvi(coord: Coord, completed: @escaping ((_ response:Uvi?, _ error:Error?) -> Void)) {
        let params = ["lat": "\(coord.lat)",
            "lon": "\(coord.lon)",
            "appid": Constants.Headers.Api_Key]
        
        Alamofire.request(Router.getUvi().path, method: Router.getUvi().method, parameters: params, encoding: URLEncoding.queryString, headers: [:])
            .validate()
            .responseObject { (alamoResponse: DataResponse<Uvi>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
        }
    }
    
    static func getUviDaily(coord: Coord, completed: @escaping ((_ response:[Uvi]?, _ error:Error?) -> Void)) {
        let params = ["lat": "\(coord.lat)",
            "lon": "\(coord.lon)",
            "appid": Constants.Headers.Api_Key]
        
        Alamofire.request(Router.getUviDaily().path, method: Router.getUviDaily().method, parameters: params, encoding: URLEncoding.queryString, headers: [:])
            .validate()
            .responseArray(completionHandler: { (alamoResponse: DataResponse<[Uvi]>) in
                completed(alamoResponse.result.value, alamoResponse.result.error)
            })
    }
}
