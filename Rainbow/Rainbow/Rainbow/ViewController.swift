//
//  ViewController.swift
//  Rainbow
//
//  Created by administrator on 05/10/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableV: UITableView!
    var colorsName = [UIColor.red, UIColor.orange , UIColor.yellow , UIColor.green,UIColor.blue,UIColor.purple]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableV.dataSource = self
        tableV.delegate = self  // add this line

    }

}

extension ViewController : UITableViewDataSource ,UITableViewDelegate {
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            // set text label to the model that is corresponding to the row in array
        cell.backgroundColor = colorsName[indexPath.row]
            // return cell so that Table View knows what to render in each row
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }


}
