//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import CoreLocation


enum LocationError {
    case denied
    case restricted
    case unknown
}

class LocationManager: NSObject {
    
    typealias LocationClosure = ((_ location:CLLocation?,_ error: LocationError?)->Void)
    private var locationCompletionHandler: LocationClosure?
    
    private var locationManager:CLLocationManager?
    var locationAccuracy = kCLLocationAccuracyBest
    
    private var lastLocation:CLLocation?
    
    static let shared: LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    private override init() {}
    
    //MARK:- Destroy the LocationManager
    deinit {
        destroyLocationManager()
    }
    
    //MARK:- Private Methods
    private func setupLocationManager() {
        
        //Setting of location manager
        locationManager = nil
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = locationAccuracy
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
    }
    
    private func destroyLocationManager() {
        locationManager?.delegate = nil
        locationManager = nil
        lastLocation = nil
    }
    
    @objc private func sendLocation() {
        guard let _ = lastLocation else {
            self.didComplete(location: nil,error: LocationError.unknown)
            lastLocation = nil
            return
        }
        self.didComplete(location: lastLocation,error: nil)
        lastLocation = nil
    }
    
    //MARK:- Public Methods
    
    /// Check if location is enabled on device or not
    
    func isLocationEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    /// Get current location
    
    func getLocation(completionHandler:@escaping LocationClosure) {
        
        //Resetting last location
        lastLocation = nil
        
        self.locationCompletionHandler = completionHandler
        
        setupLocationManager()
    }
    
    
    //MARK:- Final closure/callback
    private func didComplete(location: CLLocation?,error: LocationError?) {
        locationManager?.stopUpdatingLocation()
        locationCompletionHandler?(location,error)
        locationManager?.delegate = nil
        locationManager = nil
    }
    
    private func didCompleteGeocoding(location:CLLocation?,placemark: CLPlacemark?,error: NSError?) {
        locationManager?.stopUpdatingLocation()
        locationManager?.delegate = nil
        locationManager = nil
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    //MARK:- CLLocationManager Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last
        if let location = locations.last {
            let locationAge = -(location.timestamp.timeIntervalSinceNow)
            if (locationAge > 5.0) {
                print("old location \(location)")
                return
            }
            if location.horizontalAccuracy < 0 {
                self.locationManager?.stopUpdatingLocation()
                self.locationManager?.startUpdatingLocation()
                return
            }
            
            self.sendLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        
        case .authorizedWhenInUse,.authorizedAlways:
            self.locationManager?.startUpdatingLocation()
            
        case .denied:
            didComplete(location: nil, error: LocationError.denied)
            
        case .restricted:
            
            didComplete(location: nil,error: LocationError.restricted)
            
        case .notDetermined:
            self.locationManager?.requestLocation()
            
        @unknown default:
            didComplete(location: nil,error: LocationError.unknown)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        self.locationManager?.requestLocation()
    }
    
}
