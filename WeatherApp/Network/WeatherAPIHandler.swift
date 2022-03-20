//
//  WeatherAPIHandler.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//


import UIKit
import Alamofire


class WeatherAPIHandler: NSObject {
    static let instance = WeatherAPIHandler()
    internal var apiManager = APIManagerBase()
    
    private override init() {
        super.init()
    }
}


//MARK: - All APIs
extension WeatherAPIHandler {
    
}

