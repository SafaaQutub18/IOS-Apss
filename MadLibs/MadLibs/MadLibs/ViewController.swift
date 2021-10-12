//
//  ViewController.swift
//  MadLibs
//
//  Created by administrator on 07/10/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pragraphLabel: UILabel!
    // form result will stord here
    var infoArr = ["","","",""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add navigation button with compose icon with the function
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(navigateToNextViewController))
    }
   
    @objc func navigateToNextViewController(){
        // to move to another view
        let formVC = storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
        self.navigationController?.pushViewController(formVC , animated: true)
        
        // hide the navigation bar of the next view
                self.navigationController?.isNavigationBarHidden = true
        
        // the next line comment , we can use it insted of above if we need to do the navigation not programmaticly  اذا سوينا التنقل من الانترفيس مش كود
       /* self.performSegue(withIdentifier: "goNext", sender: self) */
        
        //next line for change back title :
       /* let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
               navigationItem.backBarButtonItem = backBarButtonItem */
    }
 
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        if infoArr[0] != "" && infoArr[1] != "" && infoArr[2] != "" && infoArr[3] != "" {
        pragraphLabel.text = "We are having a perfectly \(infoArr[0]) time now . Later we will \(infoArr[1]) and \(infoArr[2]) in the \(infoArr[3])"
        }
        
        self.navigationController?.isNavigationBarHidden = false
        
    }


}

