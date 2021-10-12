//
//  ViewController.swift
//  Test
//
//  Created by administrator on 04/10/2021.
//

import UIKit

class ViewController: UIViewController {

    var names = ["Safaa", "Salha" , "Ruba", "Noor","Nedal","Sama" , "Rawan" , "Anas" , "Shams" , "Rua" , "Enad" , "HALA" ]
    
    @IBOutlet weak var tableV: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableV.dataSource = self
        tableV.delegate = self    }


}

extension ViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel!.text = names[indexPath.row]
        cell.detailTextLabel?.text = String(Int.random(in: 1...90)) + " years old"
        return cell
    }
 
    
    
}
