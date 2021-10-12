//
//  AddItemTableViewController.swift
//  Bucket List
//
//  Created by administrator on 09/10/2021.
//

import UIKit



protocol AddedItemCVDelegate : class {
    func itemSaved(by controller: AddItemTableViewController , with text : String , at indexPath : NSIndexPath?)
    func cancelBtttonPressed(by controller: AddItemTableViewController)
}


class AddItemTableViewController: UITableViewController {
// the values of these var will gonna send from the first VC
    var item : String?
    var indexPath : NSIndexPath? // هذا نحتاج نستقبله عشان لما نعدل على النص يرجع وهوا معدل على نفس الخلية مو يضيف خلية جديدة
    
    @IBOutlet weak var TextField: UITextField!
    var delegate : AddedItemCVDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextField.text = item
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = TextField!.text!
        delegate?.itemSaved(by: self , with : text , at : indexPath)
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem){
        delegate?.cancelBtttonPressed(by: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

}
