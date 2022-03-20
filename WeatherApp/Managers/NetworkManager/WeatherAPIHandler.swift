//
//  WeatherAPIHandler.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//


import CoreLocation


class WeatherAPIHandler: NSObject {
    static let shared = WeatherAPIHandler()
    internal var apiManager = APIManagerBase()
    
    private override init() {
        super.init()
    }
}


//MARK: - All APIs
extension WeatherAPIHandler {
    
    func fetchWeatherData (latitude: CLLocationDegrees, longitude: CLLocationDegrees, success: @escaping DefaultAPISuccessClosure, failure: @escaping DefaultAPIFailureClosure) {
        
        let parameters = ["lat": latitude.description,
                          "lon": longitude.description,
                          "units": "metric",
                          "appid": Constants.weatherApiKey
                         ] as [String : Any]
        
        if let route = apiManager.getUrl(forRoute: Route.weatherInfo.rawValue, params: parameters) {
            apiManager.getRequestWith(route: route as URL, success: success, failure: failure)
        }
    }
}

