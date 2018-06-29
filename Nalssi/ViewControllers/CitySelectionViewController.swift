//
//  CitySelectionViewController.swift
//  Nalssi
//
//  Created by Corentin Redon on 6/28/18.
//  Copyright © 2018 mti. All rights reserved.
//

import UIKit

protocol CitySelectionDelegate: class {
    
    func didSelectCity(_ city: City)
}

class CitySelectionViewController: UIViewController {
    
    var cities: [City]?
    public weak var delegate: CitySelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CitySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.cityName.text = "NA, NA"
        let cityIndex: Int = indexPath.row
        if let cities = self.cities, cities.count > cityIndex {
            let cityAtIndex: City = cities[cityIndex]
            cell.cityName.text = "\(cityAtIndex.name), \(cityAtIndex.country)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityIndex: Int = indexPath.row
        if let delegate = delegate, let cities = self.cities, cityIndex < cities.count {
            delegate.didSelectCity(cities[cityIndex])
        }
        self.navigationController?.popViewController(animated: true)
    }
}
