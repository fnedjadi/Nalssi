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
    static func weatherIcon(main: String, description: String) -> UIImage {
        switch main {
        case "Clear":
            return #imageLiteral(resourceName: "sun")
        case "Clouds":
            if (description == "few clouds" || description == "scattered clouds") {
                return #imageLiteral(resourceName: "cloudy")
            }
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
    
    static func weekdayText(day: Int) -> String {
        switch day {
        case 1:
            return "Dim."
        case 2:
            return "Lun."
        case 3:
            return "Mar."
        case 4:
            return "Mer."
        case 5:
            return "Jeu."
        case 6:
            return "Ven."
        default:
            return "Sam."
        }
    }
    
    static func uvIndexColor(day: Double) -> UIColor {
        switch day {
        case -1:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        case 0..<3:
            return #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
        case 3..<6:
            return #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        case 6..<8:
            return #colorLiteral(red: 0.9137254902, green: 0.4810384115, blue: 0, alpha: 1)
        case 8..<11:
            return #colorLiteral(red: 1, green: 0.2183941619, blue: 0.1019607857, alpha: 1)
        default:
            return #colorLiteral(red: 0.4191944732, green: 0.1578097939, blue: 0.8054757714, alpha: 1)
        }
    }
}
