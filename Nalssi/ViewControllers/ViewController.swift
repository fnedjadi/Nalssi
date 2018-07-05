//
//  ViewController.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 17/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var addCityButton: UIButton!
    @IBOutlet weak var cityLoaded: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var dailyWeather : [List] = []
    var dailyUvi : [Uvi] = []
    var cities: [City]?
    var favCities: [City]?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        setupUI()
        loadCities()
        setCityDisplayed(City(id: 6455259, name: "Paris", country: "FR", coord: Coord(lon: 2.35, lat: 48.86)))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let value = manager.location?.coordinate else { return }
        print("long: \(value.longitude.binade), lat: \(value.latitude.binade)")
//        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupUI() {
        cityLabel.adjustsFontSizeToFitWidth = true
    }
    
    func loadCities() {
        BusinessManager.getCitiesAsync() {
            (cities) in
            self.cities = cities
            DispatchQueue.main.async {
                self.addCityButton.isHidden = false
                self.cityLoaded.stopAnimating()
            }
        }
    }
    
    func setCityDisplayed(_ city: City) {
        self.cityLabel.text = "\(city.name), \(city.country)"
        self.weatherLabel.text = "NA°"
        self.weatherIcon.image = ConstantDatas.weatherIcon(main: "", description: "")
        BusinessManager.getWeather(id: city.id) { (res, err) in
            if let error = err {
                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if let weather = res {
                self.weatherLabel.text = "\(weather.main?.temp ?? 0)°"
                self.weatherIcon.image = ConstantDatas.weatherIcon(main: weather.weather?.first?.main ?? "", description: weather.weather?.first?.description ?? "")
            }
        }
        
        BusinessManager.getDailyWeather(id: city.id) { (res, err) in
            if let error = err {
                let alert = UIAlertController(title: "Error for daily", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            if let weather = res {
                self.dailyWeather = weather.list ?? []
                self.tableView.reloadData()
            }
        }
        
        BusinessManager.getUviDaily(coord: city.coord) { (res, err) in
            if let error = err {
                let alert = UIAlertController(title: "Error for daily uvi", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            if let uvis = res {
                self.dailyUvi = uvis
                self.tableView.reloadData()
            }
        }
    }
    
    func addFavorite(_ city: City) {
        if let favorite = self.favCities {
            for fav in favorite {
                if fav.id == city.id {
                    return
                }
            }
            self.favCities?.append(city)
        }
        else {
            self.favCities = [city]
        }
    }
    
    func generateDates(date: Date, added: Int) -> Date {
        let dates = Calendar.current.date(byAdding: .day, value: added, to: date)!
        return dates
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCities" || segue.identifier == "showFavCities" {
            let citySelectionVC = segue.destination as! CitySelectionViewController
            citySelectionVC.cities = segue.identifier == "showCities" ? self.cities : self.favCities
            citySelectionVC.selectionMode = segue.identifier
            citySelectionVC.delegate = self
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row != 0 {
            cell.topLineView.isHidden = true
        }
        
        if !self.dailyWeather.isEmpty {
            var weather = self.dailyWeather[indexPath.row]
            let dateFormatter = DateFormatter()
            let dateFormatter2 = DateFormatter()
            let calendar = Calendar.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //2018-07-01T12:00:00Z
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter2.locale = Locale(identifier: "en_US_POSIX")
            
            for tmp in self.dailyWeather {
                let date = dateFormatter.date(from: tmp.date!) ?? Date()
                let day = calendar.component(.day, from: date)
                let day2 = calendar.component(.day, from: self.generateDates(date: Date(), added: indexPath.row + 1))
                if (day == day2) {
                    weather = tmp
                    break
                }
            }
            
            if let dateStr = weather.date { //2018-06-28 18:00:00
                let date = dateFormatter.date(from: dateStr) ?? Date()
                cell.dayLabel.text = ConstantDatas.weekdayText(day: Calendar.current.dateComponents([.weekday], from: date).weekday ?? 0)
            }
            
            cell.weatherLabel.text = "\(weather.main?.temp ?? 0)°"
            cell.weatherIcon.image = ConstantDatas.weatherIcon(main: weather.weather?.first?.main ?? "", description: weather.weather?.first?.description ?? "")
            
            if !self.dailyUvi.isEmpty {
                for uvi in dailyUvi {
                    let day = calendar.component(.day, from: dateFormatter.date(from: weather.date!)!)
                    let dayUvi = calendar.component(.day, from: dateFormatter2.date(from: uvi.date_iso!)!)
                    if day == dayUvi {
                        cell.uvIndexView.backgroundColor = ConstantDatas.uvIndexColor(day: uvi.value ?? -1)
                        cell.uvIndexView.layer.cornerRadius = cell.uvIndexView.frame.width / 2
                        break
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
}

extension ViewController: CitySelectionDelegate {
    
    func didSelectCity(_ city: City, selectionMode: String?) {
        if let selectionMode = selectionMode, selectionMode == "showCities" {
            addFavorite(city)
        }
        setCityDisplayed(city)
    }
}

