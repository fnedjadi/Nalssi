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
}
