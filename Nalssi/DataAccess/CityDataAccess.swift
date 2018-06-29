//
//  CityDataAccess.swift
//  Nalssi
//
//  Created by Corentin Redon on 6/28/18.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation

public class CityDataAccess {
    
    public static func loadDataAsync(completed: @escaping (_ cities: [City]?) -> Void) {
        let cityDataFile: String = "city.list.json"
        if let jsonFileUrl = Bundle.main.url(forResource: cityDataFile, withExtension: nil) {
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let cityData: Data = try Data(contentsOf: jsonFileUrl)
                    let decoder: JSONDecoder = JSONDecoder()
                    do {
                        let cities = try decoder.decode([City].self, from: cityData)
                        completed(cities)
                        return
                    }
                    catch {
                        print("Cannot parse \(cityDataFile) content into City objects")
                    }
                }
                catch {
                    print("Cannot read content of \(cityDataFile)")
                }
                completed(nil)
            }
        }
        else {
            print("Missing \(cityDataFile) file")
            completed(nil)
        }
    }
}
