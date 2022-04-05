//
//  FinalViewController.swift
//  clothable
//
//  Created by Nikola Jeremic on 17.3.22..
//

import UIKit
import Firebase
import CoreLocation

class FinalViewController: UIViewController {

    
    @IBOutlet weak var viewPrvi: UIImageView!
    @IBOutlet weak var viewDrugi: UIImageView!
    @IBOutlet weak var viewTreci: UIImageView!
    @IBOutlet weak var viewCetvrti: UIImageView!
    @IBOutlet weak var MyButtonGYOF: UIButton!
    
    @IBOutlet weak var searchYourLocation: UITextField!

    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "〰️ clothable"
        navigationItem.hidesBackButton = true
        
        MyButtonGYOF.layer.cornerRadius = 15
        MyButtonGYOF.layer.masksToBounds = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
       
        weatherManager.delegate = self
        searchYourLocation.delegate = self
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
            
        }
        searchYourLocation.text = ""
    }
    
}
//MARK: - WeatherManagerDelegat

extension FinalViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.viewPrvi.image = UIImage(named: weather.conditionName)
            self.viewDrugi.image = UIImage(named: weather.conditionName2)
            self.viewTreci.image = UIImage(named: weather.conditionName3)
            self.viewCetvrti.image = UIImage(named: weather.conditionName4)
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

//MARK: - CLLocationManagerDelegate

extension FinalViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitute: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
    

