//
//  FinalViewController.swift
//  clothable
//
//  Created by Nikola Jeremic on 17.3.22..
//

import UIKit
import Firebase
import CoreLocation

class FinalViewController: UIViewController, UITableViewDataSource {
  

    
    @IBOutlet weak var viewPrvi: UIImageView!
    @IBOutlet weak var viewDrugi: UIImageView!
    @IBOutlet weak var viewTreci: UIImageView!
    @IBOutlet weak var viewCetvrti: UIImageView!
    @IBOutlet weak var getYourOutfitPressed: UIButton!
    @IBOutlet weak var searchYourLocation: UITextField!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var progressBarTime: UIProgressView!
    @IBOutlet weak var cloudImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var weatherManager = WeatherManager()
    var weatherDailyManager = WeatherManagerDaily()
    
    let locationManager = CLLocationManager()
    var tabela: [WeatherDailyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getYourOutfitPressed.setTitle("", for: .normal)
        title = "〰️ clothable"
        navigationItem.hidesBackButton = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        weatherDailyManager.delegate = self
        searchYourLocation.delegate = self
        
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//
//        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")

    }
}

//MARK: - UITextFieldDelegate

extension FinalViewController: UITextFieldDelegate {
   
   @IBAction func getYourOutfitPressed(_ sender: UIButton) {
       searchYourLocation.endEditing(true)
       print(searchYourLocation.text!)
       
   }
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       searchYourLocation.endEditing(true)
       print(searchYourLocation.text!)
       return true
   }
   
  
   
   func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       if textField.text != "" {
           return true
       } else {
           textField.placeholder = "Search for location"
           return false
       }
   }
   func textFieldDidEndEditing(_ textField: UITextField)  {
       
       if let city = searchYourLocation.text {
           weatherManager.fetchWeather(imeGrada: city)
           weatherDailyManager.fetchWeatherDaily(imeGrada: city)
           
           
       }
       searchYourLocation.text = ""
   }
   
}
//MARK: - WeatherManagerDelegat

extension FinalViewController: WeatherManagerDelegate {
    
  
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async { [self] in
            self.viewPrvi.image = UIImage(named: weather.conditionName)
            self.viewDrugi.image = UIImage(named: weather.conditionName2)
            self.viewTreci.image = UIImage(named: weather.conditionName3)
            self.viewCetvrti.image = UIImage(named: weather.conditionName4)
            
            self.cityTempLabel.text = weather.temperaturaString
            self.cityNameLabel.text = weather.cityName
            self.cloudImageView.image = UIImage(named: weather.conditionNameCloud)
            self.windSpeedLabel.text = weather.speedString
            self.sunriseLabel.text = weather.sunriseInfoString
            self.sunsetLabel.text = weather.sunsetInfoString
            self.didUpdateTime(weather: weather)
        }
    }
    func didUpdateTime(weather: WeatherModel) {
        DispatchQueue.main.async { [self] in
            
            let formatterSunrise = DateFormatter()
            formatterSunrise.timeZone = TimeZone(identifier: "UTC")
            formatterSunrise.dateFormat = "HH:mm"
            sunriseLabel.text = formatterSunrise.string(from: Date(timeIntervalSince1970: TimeInterval(weather.sys)))
          
            let formatterSunset = DateFormatter()
            formatterSunset.timeZone = TimeZone(identifier: "UTC")
            formatterSunset.dateFormat = "HH:mm"
            sunsetLabel.text = formatterSunset.string(from: Date(timeIntervalSince1970: TimeInterval(weather.sys2)))
            self.progressBarTime?.progress = weather.currentProgresInfo
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
}

//MARK: - WeatherDailyManagerDelegate
extension FinalViewController: WeatherManagerDailyDelegate {
    
    
    func didUpdateWeatherDaily(weatherDaily: [WeatherDailyModel]) {
        DispatchQueue.main.async {
            self.tabela = weatherDaily
//            self.tableView.reloadData()
            
        }
    }


}


//MARK: - CLLocationManagerDelegate

extension FinalViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitute: lon)
            weatherDailyManager.fetchWeatherDaily(latitude: lat, longitute: lon)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension FinalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabela.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let currentRowData: WeatherDailyModel = self.tabela[indexPath.row]
        cell.dayLabel?.text = currentRowData.dtTxtString
        cell.tempLabel?.text = "\(currentRowData.tempInfo)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
