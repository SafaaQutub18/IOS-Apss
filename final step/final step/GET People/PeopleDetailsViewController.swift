//
//  PeopleDetailsViewController.swift
//  GET People
//
//  Created by administrator on 20/10/2021.
//

import UIKit

class PeopleDetailsViewController: UIViewController {
    var name = ""
    var gender = ""
    var mass = ""
    var birthYear = ""
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var Birth_yearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        genderLabel.text = gender
        massLabel.text = mass
        Birth_yearLabel.text = birthYear
            // Do any additional setup after loading the view.
    }
   
}
