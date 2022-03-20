//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import UIKit
import CoreLocation
import Alamofire

protocol WeatherViewModelDelegate: BaseViewModelDelegate {
    func didLoadWeatherData()
    func showEmptyView(message: String)
}

class WeatherViewModel: BaseViewModel {
    
    var dataSource: WeatherDataModel?
    
    weak var delegate: WeatherViewModelDelegate?
        
    func fetchWeatherData() {
        LocationManager.shared.getLocation { (location:CLLocation?, error:LocationError?) in
            
            if let status = error {
                switch status {
                case .denied, .restricted:
                    self.showPermissionSettingAlert()
                    break
                case .unknown:
                    break
                }
                
                self.delegate?.showEmptyView(message: "No weather info available yet.\nTap on refresh to fetch new data.\nMake sure you have enabled location permissions for the app.")
                return
            }
            
            guard let location = location else {
                return
            }
            
            let successBlock:DefaultAPISuccessClosure! = { [weak self] (response) in
                
                self?.delegate?.hideLoader()
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    let weatherData = try JSONDecoder().decode(WeatherDataModel.self, from: jsonData) //Decode JSON Response Data
                    self?.dataSource = weatherData
                    self?.delegate?.didLoadWeatherData()
                } catch {
                    // If there is no data, show empty view
                    self?.delegate?.showEmptyView(message: "No weather info available yet.\nTap on refresh to fetch new data.")
                }
            }
            
            let failureBlock:DefaultAPIFailureClosure = { error in
                
                self.delegate?.hideLoader()

                if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)! {
                    
                    self.delegate?.showEmptyView(message: "No weather info available yet.\nTap on refresh to fetch new data.\nMake sure you have active internet connection.")
                    
                    return
                }
                                
                self.delegate?.showEmptyView(message: "No weather info available yet.\nTap on refresh to fetch new data.")
            }
            
            self.delegate?.showLoader()
                        
            WeatherAPIHandler.shared.fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude, success: successBlock, failure: failureBlock)
        }
    }
    
    private func showPermissionSettingAlert(){
        let alertController = UIAlertController(title: "Allow Location Access", message: "WeatherApp needs access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)

        alertController.addAction(okAction)

        Utility.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
}
