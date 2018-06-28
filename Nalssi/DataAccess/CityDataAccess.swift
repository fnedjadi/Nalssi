//
//  CityDataAccess.swift
//  Nalssi
//
//  Created by Corentin Redon on 6/28/18.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation

public class CityDataAccess {
    
    public static func loadData() -> [City]? {
        let cityDataFile: String = "city.list.json"
        if let jsonFileUrl = Bundle.main.url(forResource: cityDataFile, withExtension: nil) {
            do {
                let cityData: Data = try Data(contentsOf: jsonFileUrl)
                let decoder: JSONDecoder = JSONDecoder()
                do {
                    return try decoder.decode([City].self, from: cityData)
                }
                catch {
                    print("Cannot parse \(cityDataFile) content into City objects")
                }
            }
            catch {
                print("Cannot read content of \(cityDataFile)")
            }
        }
        else {
            print("Missing \(cityDataFile) file")
        }
        return nil
    }
}
