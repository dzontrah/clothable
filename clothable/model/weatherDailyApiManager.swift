//
//  weatherDailyApiManager.swift
//  clothable
//
//  Created by Nikola Jeremic on 29.6.22..
//

import Foundation
import CoreLocation

protocol WeatherManagerDailyDelegate {
    func didUpdateWeatherDaily(weatherDaily: [WeatherDailyModel])
   
    
}

struct WeatherManagerDaily {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?&appid=74b8ff04103ad6283d5e5b1e8605ddf3&units=metric"
    
    
    var delegate: WeatherManagerDailyDelegate?
    
    
    func fetchWeatherDaily(imeGrada: String) {
        let urlStringDaily = "\(weatherURL)&q=\(imeGrada)"
        posaljiRequestDaily(urlString: urlStringDaily)
        print(urlStringDaily)
    }
    func fetchWeatherDaily(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
        let urlStringDailLatLon = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        posaljiRequestDaily(urlString: urlStringDailLatLon)
        print(urlStringDailLatLon)
    }
    
    func posaljiRequestDaily(urlString: String){
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let weatherDaily = self.parseJSON(weatherDailyData: safeData)
                    self.delegate?.didUpdateWeatherDaily(weatherDaily: weatherDaily)
                }
            }
            task.resume()
            
        }
        
    }
    func parseJSON(weatherDailyData: Data) -> [WeatherDailyModel] {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherDailyData.self, from: weatherDailyData)
            
            let list = decodedData.list
            print(list)

            var temporary: [WeatherDailyModel] = []
    
            for l in list {
                let weatherDaily = WeatherDailyModel(
                    dtInfo: l.dt,
                    idImage: l.weather[0].id,
                    dtTxtString:l.dt_txt,
                    tempInfo: l.main.temp)
                temporary.append(weatherDaily)
            }
            

            return temporary
            
        } catch {
            print(error)
            return []
        }
    }
}


