//
//  WeatherData.swift
//  coral indentifier
//
//  Created by PinHsuan Tsai on 2024/10/8.
//

import Foundation
import CoreLocation

/// Represents weather data for a specific location.
struct WeatherData{
    let locationName: String
    let temperature: Double
    let condition: String
}
/// Represents the response structure from the OpenWeatherMap API.
struct WeatherResponse: Codable{
    let name: String
    let main: MainWeather
    let weather: [Weather]
}
/// Represents the main weather information in the API response.
struct MainWeather: Codable {
    let temp: Double
}
/// Represents a weather condition in the API response.
struct Weather: Codable {
    let description: String
}
/// Manages location services for the app.
/// Implenment the Core Location manager for getting location updates.
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    /// Requests permission to use location services and starts updating location.
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    /// Handles location updates from the CLLocationManager.
    /// - Parameters:
    ///   - manager: The location manager providing this update.
    ///   - locations: An array of location objects, usually containing a single location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        locationManager.stopUpdatingLocation()
    }
    /// Handles errors that occur while using the location manager.
    /// - Parameters:
    ///   - manager: The location manager that encountered the error.
    ///   - error: The error that occurred.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
