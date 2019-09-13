

import Foundation
struct WeatherModel{
    let conditionID:Int
    let cityName:String
    let temperature:Double
    let description:String
    let humidity:Int
    var humidityName:String{
        let k=humidity
        return String(k)
    }
    var temperatureName:String{
        var k=temperature
        k=floor(temperature*10)/10
        return String(k)
    }
    var conditionName:String{
        switch conditionID {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }
}
