//
//  ConstantDatas.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 27/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation
import UIKit

public struct ConstantDatas {
    static func weatherIcon(main: String) -> UIImage {
        switch main {
        case "Clear":
            return #imageLiteral(resourceName: "sun")
        case "Clouds":
            return #imageLiteral(resourceName: "cloud")
        case "Rain", "Drizzle":
            return #imageLiteral(resourceName: "rain")
        case "Snow":
            return #imageLiteral(resourceName: "snow")
        case "Thunderstorm":
            return #imageLiteral(resourceName: "thunder")
        case "Atmosphere":
            return #imageLiteral(resourceName: "wind")
        default:
            return #imageLiteral(resourceName: "cloudy")
        }
    }
}
