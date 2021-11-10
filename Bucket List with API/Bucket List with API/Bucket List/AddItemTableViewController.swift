//
//  AddItemTableViewController.swift
//  Bucket List
//
//  Created by administrator on 09/10/2021.
//

import UIKit



protocol AddedItemCVDelegate : class {
    func itemSaved()
}


class AddItemTableViewController: UITableViewController {
// the values of these var will gonna send from the first VC
    var editType : String?
    var taskObject : TaskResponse?
    
    var indexPath : NSIndexPath? // هذا نحتاج نستقبله عشان لما نعدل على النص يرجع وهوا معدل على نفس الخلية مو يضيف خلية جديدة
    
    @IBOutlet weak var TextField: UITextField!
    var delegate : AddedItemCVDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextField.text = taskObject?.objective
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = TextField!.text!
        if editType == "add" {
     creatTask()
        }
        else {
            updateTask()
            
        }

    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func creatTask(){
     
        TaskModel.postTasks(objective: TextField!.text!, completionHandler: { response, error in
           
            if let response = response {
                self.delegate?.itemSaved()
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                print(response.objective)
            } else {
                print(error)
            }
        })
    }
    
    
    func updateTask(){
        guard let id = taskObject?.id else {
                  return
              }
        TaskModel.editTasks(id: id, objective: TextField!.text!, completionHandler: { response, error in
            if let response = response {
                self.delegate?.itemSaved()
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                print(response.objective)
            } else {
                print(error)
            }
        })
        
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
