//
//  ResultViewController.swift
//  QuizB
//
//  Created by administrator on 10/10/2021.
//

import UIKit

class ResultViewController: UIViewController {

    
    @IBOutlet weak var resultScoreLabel: UILabel!
    @IBOutlet weak var WordLabel: UILabel!
    
    var resultScore = 0
    var correctArray : [String] = []
    var correctWord = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(correctArray)
        
        WordLabel.text = correctArray.joined(separator: "\n")
        resultScoreLabel.text = String( resultScore)
       
    }
    
    @IBAction func restartPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindTofirst", sender: self)
    }
}
