//
//  WeatherData.swift
//  Clima
//
//  Created by Sachin Pandey on 24/03/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

/* typealias Codable = Decodable & Encodable
Codable has both the properties
 */

struct WeatherData: Codable{
    let name: String
    let main : Main
    let weather : [ Weather ]
}

struct Main: Codable{
    let temp: Double
}

struct Weather :Codable {
    let description : String
    let id: Int
}
