//
//  ViewController.swift
//  North East South West
//
//  Created by administrator on 07/10/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let directions = segue.destination as! directiomnViewController
        let bt = sender as! UIButton
        
        directions.currentDirection = (bt.titleLabel!.text)!
        
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
}

