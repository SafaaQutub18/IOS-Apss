//
//  FormViewController.swift
//  MadLibs
//
//  Created by administrator on 08/10/2021.
//

import UIKit


class FormViewController: UIViewController {
    
    @IBOutlet weak var adjTF: UITextField!
    @IBOutlet weak var verbTF1: UITextField!
    @IBOutlet weak var verbTF2: UITextField!
    @IBOutlet weak var nounTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToA", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let firstCV = segue.destination as? ViewController {
            firstCV.infoArr =  [adjTF.text!,verbTF1.text!, verbTF2.text!, nounTF.text!]
    }
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
