//
//  ViewController.swift
//  geocalculator
//
//  Created by X Code User on 9/22/17.
//  Copyright © 2017 GVSU School of Computing. All rights reserved.
//   Austin and Drew
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {
    @IBOutlet weak var lat1: DecimalMinusTextField!
    @IBOutlet weak var long1: DecimalMinusTextField!

    @IBOutlet weak var lat2: DecimalMinusTextField!
    @IBOutlet weak var long2: DecimalMinusTextField!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var bearing: UILabel!
    var distanceUnit: String = ""
    var bearingUnit: String = ""
    
    @IBAction func clearClicked(_ sender: Any) {
        lat1.text = ""
        long1.text = ""
        lat2.text = ""
        long2.text = ""
        distance.text = "Distance: "
        bearing.text = "Bearing: "
        
    }
    @IBAction func calculatePressed(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func settingsChanged(distanceUnits: String, bearingUnits: String) {
        distanceUnit = distanceUnits
        bearingUnit = bearingUnits
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: <#T##UIStoryboardSegue#>, sender: <#T##Any?#>)
    }
     */
}

