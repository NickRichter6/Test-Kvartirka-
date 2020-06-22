//
//  LocationManager.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import Foundation
import CoreLocation

typealias Coordinate = (latitude: String, longitude: String)

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    private var currenCityName: String?
    private var coordinate: Coordinate?
    private var cityDidChangeCompletion: ((String?, Coordinate, Bool) -> ())?
    
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
        
    func getCurrentCity(completion: @escaping (_ cityName: String, _ coordinate: Coordinate, _ locationServicesEnabled: Bool) -> Void) {
        
        if cityDidChangeCompletion == nil {
            cityDidChangeCompletion = { cityName, coordinate, enabled in
                completion(cityName ?? DEFAULT_CITY_NAME, coordinate, enabled)
            }
        }
        checkLocationServices()
    }
    
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            if let completion = self.cityDidChangeCompletion {
                completion(currenCityName, (latitude: DEFAULT_CITY_COORDINATE.latitude,
                            longitude: DEFAULT_CITY_COORDINATE.longitude), false)
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            if let completion = self.cityDidChangeCompletion {
                completion(currenCityName, (latitude: coordinate?.latitude ?? DEFAULT_CITY_COORDINATE.latitude,
                                            longitude: coordinate?.longitude ?? DEFAULT_CITY_COORDINATE.longitude), false)
            }
            locationManager.stopUpdatingLocation()
        case .authorizedWhenInUse:
            checkLocationServices()
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let `self` = self else { return }
            guard let placemark = placemarks?.first else { return }
            let cityName = placemark.locality
            
            if self.currenCityName != cityName {
                self.currenCityName = cityName
                if let completion = self.cityDidChangeCompletion {
                    let latitude: String = String(location.coordinate.latitude)
                    let longitude: String = String(location.coordinate.longitude)
                    self.coordinate = (latitude, longitude)
                    completion(self.currenCityName, (latitude: latitude, longitude: longitude), true)
                }
            }
        }
    }
}

