//
//  ViewController.swift
//  Tipster
//
//  Created by administrator on 02/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var groupSizeNum: UILabel!
    
    //data label
    @IBOutlet weak var percent1: UILabel!
    @IBOutlet weak var percent2: UILabel!
    @IBOutlet weak var percent3: UILabel!
    @IBOutlet weak var tipPrice1: UILabel!
    @IBOutlet weak var tipPrice2: UILabel!
    @IBOutlet weak var tipPrice3: UILabel!
    @IBOutlet weak var totalPrice1: UILabel!
    @IBOutlet weak var totalPrice2: UILabel!
    @IBOutlet weak var totalPrice3: UILabel!
    
    // data sec eow
    var tipP1 : Float = 0.0
    var tipP2 : Float = 0.0
    var tipP3 : Float = 0.0
    
    // data third eow
    var totalP1 : Float = 0.0
    var totalP2 : Float = 0.0
    var totalP3 : Float = 0.0
    
    var tipSliderValue : Int = 0
    var inputFloat : Float = 0.0
    
    
    

    
    @IBAction func enteredNumber(_ sender: UIButton) {
        let inputInt : Int = sender.tag
        if inputInt < 10 {
        inputLabel.text =  inputLabel.text! + String(inputInt)
        }
        else if inputInt == 10 {
            inputLabel.text =  inputLabel.text! + "."
        }
        else if inputInt == 11{ inputLabel.text = ""
            percent1.text = ""
            percent2.text = ""
            percent3.text = ""
            tipPrice1.text = ""
            tipPrice2.text = ""
            tipPrice3.text = ""
            totalPrice1.text = ""
            totalPrice2.text = ""
            totalPrice3.text = ""
            tipP1 = 0.0
            tipP2 = 0.0
            tipP3 = 0.0
            
            // data third eow
            totalP1 = 0.0
            totalP2 = 0.0
            totalP3 = 0.0
            
            tipSliderValue = 0
            inputFloat = 0.0
        }
    }
    
    
    @IBAction func persentSliser(_ sender: UISlider) {
        tipSliderValue = Int(sender.value)
        
        // assign percentage
        percent1.text = String(tipSliderValue) + "%"
        percent2.text = String(tipSliderValue + 5) + "%"
        percent3.text = String(tipSliderValue + 10) + "%"
        
        // calculate second row (tip price)
        //convert string to float
        if let castToFloat = Float(inputLabel.text!) {
            inputFloat = castToFloat
        }
        tipP1 = (Float(tipSliderValue) * inputFloat)/100.0
        tipP2 = (Float(tipSliderValue + 5) * inputFloat)/100.0
        tipP3 = (Float(tipSliderValue + 10) * inputFloat)/100.0
        
        tipPrice1.text = String(tipP1)
        tipPrice2.text = String(tipP2)
        tipPrice3.text = String(tipP3)
        
        
        // calculate third row (total price)
        totalP1 = tipP1 + inputFloat
        totalP2 = tipP2 + inputFloat
        totalP3 = tipP3 + inputFloat
        
        totalPrice1.text = String(totalP1)
        totalPrice2.text = String(totalP2)
        totalPrice3.text = String(totalP3)
        
    }
    
    @IBAction func groupSizeSlider(_ sender: UISlider) {
        let groupSizeValue = Int(sender.value)
        groupSizeNum.text = String(groupSizeValue)
        
        
        // calculate second row (tip price)
        
        if let castToFloat = Float(tipPrice1.text!) {
            tipP1 = castToFloat
        }
        tipP1 = tipP1 / Float(groupSizeValue)
        tipP2 = tipP2 / Float(groupSizeValue)
        tipP3 = tipP3 / Float(groupSizeValue)
        
        tipPrice1.text = String(round(tipP1))
        tipPrice2.text = String(round(tipP2))
        tipPrice3.text = String(round(tipP3))
        
        // calculate third row (total price)
        totalP1 = totalP1 / Float(groupSizeValue)
        totalP2 = totalP2 / Float(groupSizeValue)
        totalP3 = totalP3 / Float(groupSizeValue)
        
        totalPrice1.text = String(totalP1)
        totalPrice2.text = String(totalP2)
        totalPrice3.text = String(totalP3)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }


}

