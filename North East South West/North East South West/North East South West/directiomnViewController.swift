//
//  directiomnViewController.swift
//  North East South West
//
//  Created by administrator on 07/10/2021.
//

import UIKit

class directiomnViewController: UIViewController {

    @IBOutlet weak var directionL: UILabel!
    
    var currentDirection = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        directionL.text = currentDirection
        // Do any additional setup after loading the view.
    }
    @IBAction func backToATapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindTofirst", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
