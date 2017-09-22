//
//  ViewController.swift
//  geocalculator
//
//  Created by X Code User on 9/22/17.
//  Copyright © 2017 GVSU School of Computing. All rights reserved.
//   name goes here. 
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lat1: DecimalMinusTextField!
    @IBOutlet weak var long1: DecimalMinusTextField!

    @IBOutlet weak var lat2: DecimalMinusTextField!
    @IBOutlet weak var long2: DecimalMinusTextField!
    @IBAction func clearClicked(_ sender: Any) {
        lat1.text = ""
        long1.text = ""
        lat2.text = ""
        long2.text = ""
        
    }
    @IBAction func calculatePressed(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

