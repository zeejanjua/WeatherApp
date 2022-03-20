//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import UIKit
import CoreLocation

protocol WeatherViewModelDelegate: BaseViewModelDelegate {
    func didLoadWeatherData()
    func showEmptyView(message: String)
}

class WeatherViewModel: BaseViewModel {
    
    var dataSource: WeatherDataModel?
    
    weak var delegate: WeatherViewModelDelegate?
        
    // MARK: - Setups
    
    func getLocation() {
        LocationManager.shared.getLocation { (location:CLLocation?, error:LocationError?) in
            
            if let status = error {
                switch status {
                case .denied, .restricted:
                    self.showPermissionSettingAlert()
                    break
                case .unknown:
                    break
                }
                return
            }
            
            guard let location = location else {
                return
            }
            print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
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
