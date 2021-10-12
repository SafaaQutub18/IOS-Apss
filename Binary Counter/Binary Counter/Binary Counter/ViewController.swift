//
//  ViewController.swift
//  Binary Counter
//
//  Created by administrator on 06/10/2021.
//

import UIKit

class ViewController: UIViewController , BinaryCountProtocol {
    
    
    @IBOutlet var totalLb: UILabel!
    @IBOutlet weak var tableV: UITableView!
    
    var nums = [10,100,1000,10000,100000, 1000000,10000000,100000000,1000000000,10000000000, 100000000000, 1000000000000,10000000000000,100000000000000,1000000000000000,10000000000000000]
    
    
    func addTotal(value: Int) {
        let newValue = value + Int(totalLb.text!)!
        totalLb.text = String(newValue)
    }
    
    func minusTotal(value: Int) {
        let newValue = value + Int(totalLb.text!)!
        totalLb.text = String(newValue)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableV.dataSource = self
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        
        cell.delegate = self
        cell.valueL.text = String( nums[indexPath.row])
        
        return cell
    }
}

