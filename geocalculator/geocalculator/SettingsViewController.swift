//
//  SettingsViewController.swift
//  geocalculator
//
//  Created by Erin Blackwell on 9/23/17.
//  Copyright © 2017 GVSU School of Computing. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate{
    func settingsChanged(distanceUnits: String, bearingUnits: String)
}

class SettingsViewController: UIViewController {
    let distanceUnits : [String] = ["Kilometers","Miles"]
    let bearingUnits : [String] = ["Degrees", "Mils"]
    var editingDistance : Bool = true
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var bearing: UILabel!
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
       
    }
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    var selection : String = "Kilometers"
    var delegate : SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDistance))
        distance.addGestureRecognizer(gestureRecognizer)
        
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(handleBearing))
        bearing.addGestureRecognizer(gestureRecognizer2)
    
        self.pickerData = distanceUnits
        self.picker.delegate = self
        self.picker.dataSource = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let d = self.delegate {
            d.settingsChanged(distanceUnits: selection, bearingUnits: "Degrees")
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
