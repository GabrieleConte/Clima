//
//  WeatherData.swift
//  Clima
//
//  Created by Gabriele Conte on 31/08/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData: Decodable {
    let name:String
    let main:Main
    let weather: [Weather]
}
struct Main:Decodable{
    let temp:Double
    let humidity:Int
}
struct Weather:Decodable{
    let id: Int
    let description:String
}
