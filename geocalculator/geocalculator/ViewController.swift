//
//  ViewController.swift
//  geocalculator
//
//  Created by X Code User on 9/22/17.
//  Copyright © 2017 GVSU School of Computing. All rights reserved.
//   Austin and Drew
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    //used to persist data in text fields
    var text1: String?
    var text2: String?
    var text3: String?
    var text4: String?
    
    @IBOutlet weak var lat1: DecimalMinusTextField!
    @IBOutlet weak var long1: DecimalMinusTextField!

    @IBOutlet weak var lat2: DecimalMinusTextField!
    @IBOutlet weak var long2: DecimalMinusTextField!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var bearing: UILabel!
    var distanceUnit: String?
    var bearingUnit: String?
    
    @IBAction func clearClicked(_ sender: Any) {
        lat1.text = ""
        long1.text = ""
        lat2.text = ""
        long2.text = ""
        distance.text = "Distance: "
        bearing.text = "Bearing: "
        
    }
    @IBAction func calculatePressed(_ sender: Any) {
        //TODO math for distance and bearing based on distanceUnit and bearingUnit
        //also if distanceUnit is nil then assume its in Kilometers
        //same for bearingUnit, if it is nil then assume the units are Degrees
        guard   let lt1 = lat1.text, let lg1 = long1.text,
                let lt2 = lat2.text, let lg2 = long2.text,
                !lt1.isEmpty, !lg1.isEmpty,
                !lt2.isEmpty, !lg2.isEmpty
        else{
            return
        }
        
        var du = "Kilometers"
        var bu = "Degrees"
        if let distU = distanceUnit {
            du = distU
        }
        if let bearU = bearingUnit {
            bu = bearU
        }
        let latitude1 : Double = Double(lt1)!
        let longitude1 : Double = Double(lg1)!
        let latitude2 : Double = Double(lt2)!
        let longitude2 : Double = Double(lg2)!
        let point1 = CLLocation(latitude: latitude1, longitude: longitude1)
        let point2 = CLLocation(latitude: latitude2, longitude: longitude2)
        var bearing = point1.bearingToPoint(point: point2)
        var distance = point2.distance(from: point1) / 1000
        if (bu == "Mils"){
            bearing = bearing * 17.777777777778
        }
        if (du == "Miles"){
            distance = distance * 0.621371
        }
        distance = round(100 * distance) / 100
        bearing = round(100 * bearing) / 100
        self.distance.text = "Distance: \(distance) \(du)"
        self.bearing.text = "Bearing: \(bearing) \(bu)"
        dismissKeyboard()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        lat1.text = text1
        long1.text = text2
        lat2.text = text3
        long2.text = text4
        calculatePressed(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSettings"
        {
            if let destVC = segue.destination.childViewControllers[0] as? SettingsViewController {
                destVC.currentBearingUnit = self.bearingUnit
                destVC.currentDistanceUnit = self.distanceUnit
                destVC.text1 = self.lat1.text
                destVC.text2 = self.long1.text
                destVC.text3 = self.lat2.text
                destVC.text4 = self.long2.text
            }
        }
      
    }
}

