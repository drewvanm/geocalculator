//
//  SettingsViewController.swift
//  geocalculator
//
//  Created by Erin Blackwell on 9/23/17.
//  Copyright © 2017 GVSU School of Computing. All rights reserved.
//

import UIKit



class SettingsViewController: UIViewController {
    let distanceUnits : [String] = ["Kilometers","Miles"]
    let bearingUnits : [String] = ["Degrees", "Mils"]
    
    var currentDistanceUnit : String?
    var currentBearingUnit : String?
    
    var editingDistance : Bool = true
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var bearing: UILabel!
    
  
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    var selection : String = "Kilometers"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dist = currentDistanceUnit {
            self.distance.text = dist
        }
        if let bear = currentBearingUnit {
            self.bearing.text = bear
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDistance))
        distance.addGestureRecognizer(gestureRecognizer)
        
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(handleBearing))
        bearing.addGestureRecognizer(gestureRecognizer2)
    
        self.pickerData = distanceUnits
        self.picker.delegate = self
        self.picker.dataSource = self
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCalcFromCancel"
        {
            if let destVC = segue.destination.childViewControllers[0] as? ViewController {
                destVC.bearingUnit = self.currentBearingUnit
                destVC.distanceUnit = self.currentDistanceUnit
            }
        }
        else if segue.identifier == "segueToCalcFromSave"
        {
            if let destVC = segue.destination.childViewControllers[0] as? ViewController {
                destVC.bearingUnit = self.bearing.text
                destVC.distanceUnit = self.distance.text
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleDistance(getureRecognizer: UIGestureRecognizer)
    {
        picker.isHidden = false
        self.pickerData = distanceUnits
        self.picker.dataSource = self
        editingDistance = true
    }
    
    func handleBearing(getureRecognizer: UIGestureRecognizer)
    {
        picker.isHidden = false
        self.pickerData = bearingUnits
        self.picker.dataSource = self
        editingDistance = false
    }
}
extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selection = self.pickerData[row]
        if editingDistance
        {
            distance.text = self.selection
        }
        else
        {
            bearing.text = self.selection
        }
    }
}
