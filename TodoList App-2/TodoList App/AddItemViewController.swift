//
//  AddItemViewController.swift
//  TodoList App
//
//  Created by administrator on 14/10/2021.
//

import UIKit

class AddItemViewController: UIViewController {

    var delegate : AddedItemDelegate?
    var dateString : String = "" 
    
  //  var indexPath : Int16 = 0
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var noteTF: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   func datePickerToString()-> String{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
       return dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        
        dateString = datePickerToString()
        //print("jhdjshjdhjhjhjhjhjhjhjhjhjh \(dateString)")
        delegate?.AddItemPressed(controller : self, title: titleTF!.text!, notes: noteTF!.text!, date: dateString )
        
        
    }
  

}


protocol AddedItemDelegate : AnyObject {
    func AddItemPressed(controller: AddItemViewController ,  title : String, notes : String , date : String)
}
