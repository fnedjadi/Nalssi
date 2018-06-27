//
//  Constants.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 27/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import Alamofire

struct Constants {
    
    struct Url {
        static let ENTRY_API_URL = "http://api.openweathermap.org/data/2.5/"
        static let WEATHER = "weather"
    }
    
    struct Headers {
        static let Api_Key = "d849e137d6f4d444bc6877ab440e3468"
        static let headers: HTTPHeaders = [
            "api_key": Headers.Api_Key
        ]
    }
}
