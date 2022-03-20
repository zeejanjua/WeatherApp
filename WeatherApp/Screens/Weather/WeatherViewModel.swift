//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import Foundation

protocol WeatherViewModelDelegate: BaseViewModelDelegate {
    func didLoadWeatherData()
    func showEmptyView(message: String)
}

class WeatherViewModel: BaseViewModel {
    
}
