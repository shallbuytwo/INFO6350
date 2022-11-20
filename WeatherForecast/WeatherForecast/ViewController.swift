//
//  ViewController.swift
//  WeatherForecast
//
//  Created by wei wang on 11/19/22.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    var lat = 0.0
    var lng = 0.0
    var state = "WA"
    var city = "Seattle"
    var postalCode = "98101"
    var temps = [String]()
    
    @IBOutlet weak var txtLocation: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    @IBAction func getWeather(_ sender: Any) {
        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
        let locationStr = txtLocation.text
        url += locationStr!
        url += "&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"
        SwiftSpinner.show("Getting Weather Forecast")
        AF.request(url).responseJSON { responseData in
            SwiftSpinner.hide()
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            let weatherData = JSON(responseData.data as Any)
            let forecastValues =  weatherData["locations"][self.txtLocation.text!]["values"]
            print(forecastValues.count)
            self.temps = [String]()
            for forecast in forecastValues {
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                let str = "Temperature = \(temp),\(condition)"
                self.temps.append(str)
            }
            self.tableView.reloadData()

        }
    }
            
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                guard let location = locations.last else { return }
                
                self.lat = location.coordinate.latitude
                self.lng = location.coordinate.longitude
                
                getAddressFromLocation(location: location)
                
            }
            
            
            @IBAction func getLocation(_ sender: Any) {
                locationManager.requestLocation()
                txtLocation.text = "\(self.city),\(self.state)"
                
            }
            
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                print(error)
            }
            func getAddressFromLocation( location: CLLocation){
                
                let clGeoCoder = CLGeocoder()
                
                clGeoCoder.reverseGeocodeLocation(location) { placeMarks, error in
                    
                    if error != nil {
                        return            }
                    guard let place = placeMarks?.first else { return }
                    
                    
                    if place.locality != nil {
                        self.city = place.locality!
                    }
                    if place.administrativeArea != nil {
                        self.state = place.administrativeArea!
                    }
                    
                    if place.postalCode != nil {
                        self.postalCode = place.postalCode!
                    }
                }
                
            }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temps.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = temps[indexPath.row]
        return cell
    }
            
        }
