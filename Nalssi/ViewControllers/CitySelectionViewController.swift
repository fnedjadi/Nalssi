//
//  CitySelectionViewController.swift
//  Nalssi
//
//  Created by Corentin Redon on 6/28/18.
//  Copyright © 2018 mti. All rights reserved.
//

import UIKit

protocol CitySelectionDelegate: class {
    
    func didSelectCity(_ city: City, selectionMode: String?)
}

class CitySelectionViewController: UIViewController {
    
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cities: [City]?
    let sectionName: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]
    var sections: [[City]] = Array<[City]>(repeating: [], count: 27)
    var backup: [[City]] = Array<[City]>(repeating: [], count: 27)
    var previousFilter: String = ""
    var selectionMode: String?
    public weak var delegate: CitySelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getSectionCities()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        if cities == nil {
            cityTableView.separatorStyle = .none
            searchBar.removeFromSuperview()
        }
    }
    
    func getSectionCities(with filter: String = "") {
        guard let cities = self.cities else { return }
        for city in cities {
            if city.name.hasPrefix(filter) {
                var indexOfSection: Int = sections.count - 1
                if let sectionLetter = city.name.uppercased().first {
                    indexOfSection = sectionLetter - Character("A")
                }
                sections[indexOfSection < 0 ? 0 : indexOfSection].append(city)
            }
        }
    }
}

extension CitySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cities == nil ? 1 : sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities == nil ? 1 : sections[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cities == nil ? nil : sectionName[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return cities == nil ? nil : sectionName
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityTableViewCell = tableView.dequeueReusableCell(withIdentifier: cities == nil ? "emptyTableViewCell" : "cityCell", for: indexPath) as! CityTableViewCell
        if let _ = cities {
            let cityAtIndex: City = sections[indexPath.section][indexPath.row]
            cell.cityName.text = "\(cityAtIndex.name), \(cityAtIndex.country)"
        }
        else {
            cell.cityName.text = "🏘 Aucun lieu 🏘"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cities == nil ? 220 : 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectCity(sections[indexPath.section][indexPath.row], selectionMode: selectionMode)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension CitySelectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filter(on: searchBar.text ?? "")
    }
    
    func filter(on text: String) {
        if previousFilter.count < text.count && text.hasPrefix(previousFilter) {
            filterByIncreasingText(text)
        }
        else {
            filterByReducingText(text)
        }
        previousFilter = text
        self.cityTableView.reloadData()
    }
    
    func filterByReducingText(_ filter: String) {
        sections = Array<[City]>(repeating: [], count: 27)
        getSectionCities(with: filter)
    }
    
    func filterByIncreasingText(_ filter: String) {
        for (index, section) in sections.enumerated() {
            var newRow: [City] = []
            for row in section {
                if row.name.hasPrefix(filter) {
                    newRow.append(row)
                }
            }
            sections[index] = newRow
        }
    }
}
