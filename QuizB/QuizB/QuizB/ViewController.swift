//
//  ViewController.swift
//  QuizB
//
//  Created by administrator on 10/10/2021.
//

import UIKit

class ViewController: UIViewController {
    //varibles of timer
    var countdownTimer: Timer!
    var totalTime = 60
    
    
    
    ///
    var words = ["Toys", "Beach Ball" , "Waves" , "Hearts", "Spider" , "Bed", "Clothes" ,"sheep" ]
    
    //
    var playedword : [String] = []
    var correctAnswers : [String] = []
    var score : Int = 0
    
    //varibles of the view
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBAction func newCardButtonPessed(_ sender: UIButton) {
       
        if words.count > 0 {
            randomWord()
            //increse score
            score += 1
            scoreLabel.text = String(score)
            correctAnswers.append(playedword[playedword.count-1])
        }
        else {
            let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            
            // send data to other view
            
            resultVC.correctArray = correctAnswers
            
            resultVC.resultScore = score
            
            self.present(resultVC, animated: true, completion: nil)
            
            
           
        }
    }
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        if words.count > 0 {
            randomWord()
        }
        else {
            let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            
            // send data to other view
            
            resultVC.correctArray = correctAnswers
            
            resultVC.resultScore = score
            
            self.present(resultVC, animated: true, completion: nil)
    }
    }
    // generate the random word without repeatation
    func randomWord(){
        if words.count > 0 {
        let random = Int.random(in: 0...words.count - 1)
        wordLabel.text = String( words[random])
        playedword.append(words.remove(at: random))
        }
    }
    
    //unwind func :
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
        score = 0
        scoreLabel.text = "0"
        words = ["Toys", "Beach Ball" , "Waves" , "Hearts", "Spider" , "Bed", "Clothes" ,"sheep" ]
        
        //
        playedword = []
        correctAnswers = []
        score = 0
        wordLabel.text = ""
        
        viewDidLoad()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startTimer()
        randomWord()
    }
}

    
        
        
        


// this extension contains the methods of timer
extension ViewController {
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"

        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }

    func endTimer() {
        countdownTimer.invalidate()
        
        // go to result view
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        
        // send data to other view
        
        resultVC.correctArray = correctAnswers
        
        resultVC.resultScore = score
        
        self.present(resultVC, animated: true, completion: nil)
}
    


    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }


    @IBAction func startTimerPressed(_ sender: UIButton) {
        startTimer()
    }
}

 
// timer refrence : https://teamtreehouse.com/community/swift-countdown-timer-of-60-seconds
