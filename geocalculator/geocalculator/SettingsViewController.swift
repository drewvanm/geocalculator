//
//  SettingsViewController.swift
//  geocalculator
//
//  Created by Erin Blackwell on 9/23/17.
//  Copyright © 2017 GVSU School of Computing. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate{
    func settingChanged(distanceUnits: String, bearingUnits: String)
}

class SettingsViewController: UIViewController {
    var delegate : SettingsViewControllerDelegate?
    let distanceUnits : [String] = ["Kilometers","Miles"]
    let bearingUnits : [String] = ["Degrees", "Mils"]
    
    var currentDistanceUnit : String?
    var currentBearingUnit : String?
    
    var editingDistance : Bool = true
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var bearing: UILabel!
    
    @IBAction func SavePressed(_ sender: Any) {
        if let d = self.delegate {
            d.settingChanged(distanceUnits: distance.text!, bearingUnits: bearing.text!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        if let d = self.delegate {
            if currentDistanceUnit == nil || currentBearingUnit == nil{
                d.settingChanged(distanceUnits: "Kilometers" , bearingUnits: "Degrees")
            }
            else{
                d.settingChanged(distanceUnits: currentDistanceUnit! , bearingUnits: currentBearingUnit!)

            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    var selection : String = "Kilometers"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detectTouch1 = UITapGestureRecognizer(target: self, action: #selector(dismissSettingsKeyboard))
        self.view.addGestureRecognizer(detectTouch1)

        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDistance))
        distance.addGestureRecognizer(gestureRecognizer)
        
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(handleBearing))
        bearing.addGestureRecognizer(gestureRecognizer2)
    
        if let du = currentDistanceUnit{
            distance.text = du
        }
        if let bu = currentBearingUnit{
            bearing.text = bu
        }
        self.pickerData = distanceUnits
        self.picker.delegate = self
        self.picker.dataSource = self
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
   
    func dismissSettingsKeyboard(){
        self.picker.isHidden = true
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
