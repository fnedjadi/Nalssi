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
    var previousFilter: String = ""
    var selectionMode: String?
    public weak var delegate: CitySelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        self.sections = getSectionCities()
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
    
    func getSectionCities(with filter: String = "") -> [[City]] {
        var newSections: [[City]] = Array<[City]>(repeating: [], count: 27)
        guard let cities = self.cities else { return newSections }
        for city in cities {
            if city.name.lowercased().hasPrefix(filter) {
                var indexOfSection: Int = newSections.count - 1
                if let sectionLetter = city.name.uppercased().first {
                    indexOfSection = sectionLetter - Character("A")
                }
                newSections[indexOfSection < 0 ? 0 : indexOfSection].append(city)
            }
        }
        return newSections
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filter(on: "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(on: searchBar.text?.lowercased() ?? "")
    }
    
    func filter(on text: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            var newSections: [[City]] = []
            if self.previousFilter.count < text.count && text.hasPrefix(self.previousFilter) {
                newSections = self.filterByIncreasingText(text)
            }
            else {
                newSections = self.filterByReducingText(text)
            }
            DispatchQueue.main.async {
                self.sections = newSections
                self.previousFilter = text
                self.cityTableView.reloadData()
            }
        }
    }
    
    func filterByReducingText(_ filter: String) -> [[City]] {
        return getSectionCities(with: filter)
    }
    
    func filterByIncreasingText(_ filter: String) -> [[City]] {
        var newSections: [[City]] = []
        for section in sections {
            var newRow: [City] = []
            for row in section {
                if row.name.lowercased().hasPrefix(filter) {
                    newRow.append(row)
                }
            }
            newSections.append(newRow)
        }
        return newSections
    }
}
