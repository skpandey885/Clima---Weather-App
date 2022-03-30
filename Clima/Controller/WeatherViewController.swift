//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController , UITextFieldDelegate, WeatherManagerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    
    var obj=WeatherManager()
    var locman = CLLocationManager ()
    override func viewDidLoad() {
        super.viewDidLoad()
        locman.delegate=self
        locman.requestWhenInUseAuthorization()
        locman.requestLocation()
        
        myTextField.delegate = self
         obj.delegate=self

            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
    }


    @IBAction func buttonClicked(_ sender: UIButton) {
        locman.requestLocation()
    }
    

    @IBAction func searchPressed(_ sender: UIButton) {
        myTextField.endEditing(true)
        print(myTextField.text! )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.endEditing(true)
            print(myTextField.text! )
        return true
    }

    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if( myTextField.text != ""){
            return true;
        }else{
             myTextField.placeholder="Type something.."
            return false
}}
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        obj.fetch(textField.text!)
        myTextField.placeholder="Enter a city name.."
        myTextField.text=""
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func didUpdate(_ cc: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text=cc.tempString
            self.cityLabel.text=cc.name
            self.conditionImageView.image = UIImage(systemName: cc.conditionName)
        }
    
    }
    
    func didFailwithError(_ error: Error) {
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location  = locations.last{
        let lat=location.coordinate.latitude
        let lon=location.coordinate.longitude
          obj.fetch(lat: lat, lon: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

