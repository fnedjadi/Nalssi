//
//  ViewController.swift
//  Nalssi
//
//  Created by Farah Nedjadi on 17/06/2018.
//  Copyright © 2018 mti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setCityDisplayed(City(id: 6455259, name: "Paris", country: "FR", coord: Coord(lon: 0, lat: 0)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setCityDisplayed(_ city: City) {
        BusinessManager.getWeather(id: city.id) { (res, err) in
            if let error = err {
                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if let weather = res {
                self.weatherLabel.text = "\(weather.main?.temp ?? 0)°"
                self.cityLabel.text = "\(weather.name ?? "N/A"), \(weather.sys?.country ?? "N/A")"
                self.weatherIcon.image = ConstantDatas.weatherIcon(main: weather.weather?.first?.main ?? "")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCities" {
            let citySelectionVC = segue.destination as! CitySelectionViewController
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
        
        cell.dayLabel.text = "Dim."
        cell.weatherLabel.text = "20°"
        cell.weatherIcon.image = #imageLiteral(resourceName: "sun")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
}

extension ViewController: CitySelectionDelegate {
    
    func didSelectCity(_ city: City) {
        setCityDisplayed(city)
    }
}

