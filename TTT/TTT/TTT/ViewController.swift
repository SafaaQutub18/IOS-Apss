//
//  ViewController.swift
//  TTT
//
//  Created by administrator on 01/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    //buttons
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    
    
    
    
    
    
    @IBOutlet weak var resetBt: UIButton!
    @IBOutlet weak var congMsg: UILabel!
    var playerRole = 1
    var stateOfGame = [0,0,0,0,0,0,0,0,0]
    var isActive = true
    var wainningCases = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    @IBAction func BottonsClicks(_ sender: UIButton) {
        if stateOfGame[sender.tag] == 0 && isActive == true {
            stateOfGame[sender.tag] = playerRole
            if playerRole == 1{
                sender.backgroundColor = UIColor.red
                playerRole = 2
            }
            else {
                sender.backgroundColor = UIColor.blue
                playerRole = 1
            }
        }
            
        for currentCase in wainningCases {
            
            if stateOfGame[currentCase[0]] != 0 && stateOfGame[currentCase[0]] ==  stateOfGame[currentCase[1]] && stateOfGame[currentCase[1]] ==  stateOfGame[currentCase[2]] {
            isActive = false
            if stateOfGame[currentCase[0]] == 1 {
                congMsg.text = "congrats red won"
        }
            else{congMsg.text = "congrats blue won"
                
            }
        }

        }
        isActive = false
        for state in stateOfGame{
            if state == 0 {
                isActive = true
                return
            }
        }
        
        }
    
    @IBAction func gameReset(_ sender: UIButton) {
        stateOfGame = [0,0,0,0,0,0,0,0,0]
        isActive = true
        playerRole = 1
        congMsg.text = ""
        
        b1.backgroundColor = UIColor.gray
        b2.backgroundColor = UIColor.gray
        b3.backgroundColor = UIColor.gray
        b4.backgroundColor = UIColor.gray
        b5.backgroundColor = UIColor.gray
        b6.backgroundColor = UIColor.gray
        b7.backgroundColor = UIColor.gray
        b8.backgroundColor = UIColor.gray
        b9.backgroundColor = UIColor.gray
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

