//
//  WeatherManager.swift
//  Clima
//
//  Created by Gabriele Conte on 31/08/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherMananger:WeatherManager,weather:WeatherModel)
    func passErrors(error:Error)
}

struct WeatherManager{
    var weatherURL="https://api.openweathermap.org/data/2.5/weather?appid=5a3ed3c2ffe7add052568f24c5357bfc&units=metric&lang=it"
    var weatherCoordinatesURL="https://api.openweathermap.org/data/2.5/weather?appid=5a3ed3c2ffe7add052568f24c5357bfc&units=metric&lang=it"
    
    var delegate:WeatherManagerDelegate?
    func fetchWeather(cityName:String){
        let urlString="\(weatherURL)&q=\(cityName)"
        self.performRequest(urlString)
    }
    func fetchWeather(Longitude:CLLocationDegrees,Latitude:CLLocationDegrees){
        let urlString="\(weatherCoordinatesURL)&lon=\(Longitude)&lat=\(Latitude)"
        self.performRequest(urlString)
    }

    
    func performRequest(_ urlString:String){
        //crea URL
        if let url=URL(string: urlString){
            //crea URL session
            let session=URLSession(configuration: .default)
            //Dire alla sessione cosa fare
            let task=session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    delegate?.passErrors(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather=self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            //avvia la query
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data)->WeatherModel?{
        let decoder = JSONDecoder()
        
        do{
        let decodedData=try decoder.decode(WeatherData.self, from: weatherData)
            let id=decodedData.weather[0].id
            let temp=decodedData.main.temp
            let name=decodedData.name
            let descript=decodedData.weather[0].description
        let humid=decodedData.main.humidity
            let weather=WeatherModel(conditionID: id, cityName: name, temperature: temp,description:descript,humidity:humid)
            return weather
            
            
        }catch{
            delegate?.passErrors(error: error)
            return nil
            
        }
    }
    
    }
