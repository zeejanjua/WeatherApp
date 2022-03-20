//
//  Constants.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import Foundation


struct Constants {

    static let appName = "WeatherApp"
    static let bundleId = "com.app.WeatherApp"
    
    static let weatherApiKey = "22809ef7fc06e4d1db75a2be3a52d7f4"
    
    /** BASE URL */
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    static let imageBaseURL = "http://openweathermap.org/img/wn/"
    
}


enum Strings: String {
   
    case error = "Error!"
    
    //MARK: - Error Messages
    
    case noRecords = "Sorry!, we couldn't find any movie"
    case noNetwork = "no_network"
    case timeOut = "time_out"
    case errorOccured = "error_occured"
    case badRequest = "bad_request"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
}


struct ErrorMessage {
    private init() {}
    
    static let network = NeworkAlerts()
}


struct NeworkAlerts {
    fileprivate init() {}
    
    var noNetwork: String {
        return Strings.noNetwork.localized
    }
    var timeOut: String {
        return Strings.timeOut.localized
    }
    var errorOccured: String {
        return Strings.errorOccured.localized
    }
    var badRequest: String {
        return Strings.badRequest.localized
    }
}
