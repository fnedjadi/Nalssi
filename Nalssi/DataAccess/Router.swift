//
//  Router.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 27/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol RouterProtocol {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
}

enum Router {
    case getWeather()
}

extension Router : RouterProtocol {
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return Constants.Url.ENTRY_API_URL + Constants.Url.WEATHER
        }
    }
    
    fileprivate var headers: HTTPHeaders {
        return Constants.Headers.headers
    }
}

extension Router: URLRequestConvertible {
    public func asURLRequest () -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: self.path)!)
        urlRequest.httpMethod = self.method.rawValue
        return urlRequest
    }
}
