//
//  PostData.swift
//  Clima
//
//  Created by Elliot Tsai on 12/9/19.
//  Copyright © 2019 Elliot Tsai. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let main: Main
    let name: String
    let weather: [WeatherData]
    
}

struct Main: Decodable {
    let temp: Double
    }

struct WeatherData: Decodable {
    let description: String
    let id: Int
}
