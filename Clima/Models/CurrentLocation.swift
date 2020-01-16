//
//  CurrentLocation.swift
//  Clima
//
//  Created by Elliot Tsai on 12/13/19.
//  Copyright © 2019 Elliot Tsai. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationFetcherDelegate {
    func didUpdateLocation(_ locationAt: LocationFetcher, location: CLLocationCoordinate2D)
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var delegate: LocationFetcherDelegate?
    
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func startLocating() {
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        locationManager.stopUpdatingLocation()
    }
    
}
