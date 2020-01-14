//
//  WeatherManager.swift
//  Clima
//
//  Created by Elliot Tsai on 12/9/19.
//  Copyright © 2019 Elliot Tsai. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherManager: ObservableObject, LocationFetcherDelegate {
    let currentLocation = LocationFetcher()
    func didUpdateLocation(_ locationAt: LocationFetcher, location: CLLocationCoordinate2D) {
        fetchLocation()
    }
    
    @Published var temperature = "52°"
    @Published var city = "City"
    @Published var weatherIcon = 1
    @Published var iconData = "sun.min"
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f1a43a266c4be561bc4715f0b8b4d193&units=imperial"
    
    init() {
        //currentLocation.delegate.self
        currentLocation.delegate = self
        
    }
    
    func fetchLocation() {
        let lat = currentLocation.lastKnownLocation?.latitude
        let lon = currentLocation.lastKnownLocation?.longitude
        print("lat: \(lat), Long: \(lon)")
        let formattedString = "\(weatherURL)&lat=\(lat!)&lon=\(lon!)"
        fetch(formattedString: formattedString)
    }
    
    func fetchWeather(cityname: String) {
        let formattedName = cityname.replacingOccurrences(of: " ", with: "+")
        let formattedString = "\(weatherURL)&q=\(formattedName)"
        fetch(formattedString: formattedString)
    }
    
    func fetch(formattedString: String) {
        if let url = URL(string: formattedString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let environmentalData = try decoder.decode(Weather.self, from: safeData)
                            
                            self.temperature = "\(environmentalData.main.temp)"
                            self.weatherIcon = environmentalData.weather[0].id
                            self.city = "\(environmentalData.name)"
                            
                            var iconWeather: String {
                                switch self.weatherIcon {
                                case 200...232:
                                    return "cloud.bolt"
                                case 300...321:
                                    return "cloud.drizzle"
                                case 500...531:
                                    return "cloud.rain"
                                case 600...622:
                                    return "snow"
                                case 701...781:
                                    return "sun.haze"
                                case 800:
                                    return "sun.max"
                                case 801...804:
                                    return "cloud"
                                default:
                                    return "sun.min"
                                }
                            }
                            self.iconData = iconWeather
                            
                        }
                        catch {
                            print(error)
                        }
                        
                    }
                    
                }
                
            }
            task.resume()
        }
    }
}






