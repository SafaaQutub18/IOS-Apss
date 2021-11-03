//
//  SportCustomCell.swift
//  Sports and Players
//
//  Created by administrator on 26/10/2021.
//

import UIKit

class SportCustomCell: UITableViewCell {
    var cellindexPath : Int?
    var delegate : imagePickerDelegate?
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var sportNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        print(delegate)
        delegate?.imagePick(cellIndexPath: cellindexPath!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol imagePickerDelegate : class {
    func imagePick(cellIndexPath : Int)
}
