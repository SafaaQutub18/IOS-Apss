//
//  TableViewCell.swift
//  Binary Counter
//
//  Created by administrator on 06/10/2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    weak var delegate: BinaryCountProtocol?
    @IBOutlet weak var valueL: UILabel!
    

    @IBAction func minusButton(_ sender: UIButton) {
        let newValue = 0 -  Int(valueL.text!)!
        delegate?.minusTotal( value : newValue)
        
    }
    @IBAction func addButton(_ sender: UIButton) {
        let newValue = Int(valueL.text!)!
        delegate?.addTotal( value : newValue)
    }
   
    

}
