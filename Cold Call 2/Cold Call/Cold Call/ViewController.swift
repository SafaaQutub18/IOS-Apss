//
//  ViewController.swift
//  Cold Call
//
//  Created by administrator on 01/10/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var ColdCallBt: UIButton!
    
    @IBOutlet weak var numLabel: UILabel!
    
    var num = 0
    
    var names = ["Safaa", "Nedal" , "Ruba", "Osaid", "Salha" , "Salman" , "Salma"]

    @IBAction func coldCall(_ sender: UIButton) {
        namesLabel.text = names[Int.random(in: 0..<5)]
        num = Int.random(in: 1...5)
        switch num {
        case 1,2 :
            numLabel.text = String(num)
            numLabel.textColor = UIColor.red
        case 3,4 :
            numLabel.text = String(num)
            numLabel.textColor = UIColor.orange
        case 5 :
            numLabel.text = String(num)
            numLabel.textColor = UIColor.green
        default: numLabel.text = String(num)
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        namesLabel.text = names[Int.random(in: 0..<5)]
    }


}

