//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    let locationManager=CLLocationManager()
    @IBOutlet weak var descrizione: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var humidity: UILabel!
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        locationManager.delegate=self
        weatherManager.delegate=self
        searchTF.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func myPosition(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}
//MARK: -UITextFieldDeleegate
extension WeatherViewController:UITextFieldDelegate{
    
    @IBAction func searchPressed(_ sender: UITextField) {
        searchTF.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTF.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let weather=searchTF.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        weatherManager.fetchWeather(cityName: weather!)
        searchTF.text=""
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
        return true
        }else{
            textField.placeholder="Type something"
            return false
        }
    }
}
//MARK: -WeatherManagerDeleegate
extension WeatherViewController:WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherMananger:WeatherManager,weather:WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text=weather.temperatureName
            self.conditionImageView.image=UIImage(systemName: weather.conditionName)
            self.cityLabel.text=weather.cityName
            self.descrizione.text=weather.description
            self.humidity.text=weather.humidityName
        }
        
    }
    func passErrors(error: Error) {
        print(error)
    }

}

//MARK: -Location extension
extension WeatherViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location=locations.last{
            locationManager.stopUpdatingLocation()
            let latitude=location.coordinate.latitude
            let longitude=location.coordinate.longitude
            weatherManager.fetchWeather(Longitude:longitude,Latitude:latitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
