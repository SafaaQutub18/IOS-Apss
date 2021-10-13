//
//  ViewController.swift
//  Bucket List
//
//  Created by administrator on 09/10/2021.
//

import UIKit
import CoreData

class BucketListViewController : UITableViewController , AddedItemCVDelegate {
    

    var items : [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        readItem()
    }

    

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func itemSaved(by controller: AddItemTableViewController , with text : String , at indexPath : NSIndexPath?) {
        if let ip = indexPath { // check if we send the indexpath that mean we want to edit the item
            updateItem(itemName: text, indexPath: ip.row)
        }
        else{
            // call the func that will add the data to database
            addItem(text: text)
               }
                tableView.reloadData()
                dismiss(animated: true, completion: nil)
    }
            
    func cancelBtttonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      //  if segue.identifier == "AddItemSegue" {
        let navigationController = segue.destination as! UINavigationController
        let addItemTableVC = navigationController.topViewController as! AddItemTableViewController
        addItemTableVC.delegate = self
            
        //check if the sender is edit
        if sender is NSIndexPath {
            // send the data (clicked item) to AddItemTableViewController to edit it
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row] as! BucketListItem
            addItemTableVC.item = item.text // صار لازم اكتب اسم ال proprety
            addItemTableVC.indexPath = indexPath
        }
    }
    
    ////////////////////////////////DataBase Function/////////////////////////////////////////////////
    
    //function that responciple for the connection with DB
    //MARK: - Get updated context, to avoid having global object for your context
     func getUpdatedContext() -> NSManagedObjectContext? {
         let delegate = UIApplication.shared.delegate as! AppDelegate
         return delegate.persistentContainer.viewContext
     }
     

    //MARK: - Add items to data base
    func addItem(text:String) {
            guard let context = getUpdatedContext() else {
                return
            }
        
        let item = BucketListItem.init(context: context)
            item.text = text
            do {
                try context.save()
                items.append(item)
                tableView.reloadData()
            } catch {
                print("Error: \(error)")
            }
        }
    
    //MARK: - Read items from data base
        func readItem() {
            guard let context = getUpdatedContext() else {
                return
            }
            let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BucketListItem")
            do {
                let result = try context.fetch(request)
                items = result as! [BucketListItem] // return the data that stored in DB as list
                tableView.reloadData()
            } catch {
                print("Read Error:\(error)")
            }
        }
    
    //MARK: - Update with single predicate
    func updateItem(itemName: String, indexPath: Int){
        guard let context = getUpdatedContext() else {
            return
        }
        // Old text
        let oldItemText = items[indexPath] as! BucketListItem
        // read
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BucketListItem")
        
        // I do not understand why we must wite the next line T__T
        let predcate = NSPredicate.init(format: "text = %@", oldItemText.text!)
       // request.predicate =  NSCompoundPredicate.init(andPredicateWithSubpredicates: [predcate]) // the predicate
        request.predicate = predcate
        do {
            let result = try context.fetch(request).first
            let bucketListItem = result as! BucketListItem
            bucketListItem.text = itemName

            try context.save()
                readItem()
        } catch {
            print(" update faild \(error)")
        }
    }
    
    
    //MARK: - Delete object for a given value
    func deleteItem(text : String) {
         guard let context = getUpdatedContext() else {
             return
         }
         
         let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BucketListItem")
         request.predicate = NSPredicate.init(format: "text = %@", text)
         
         do {
             let item = try context.fetch(request).first as! BucketListItem
             context.delete(item)
             try context.save()
             readItem()
         } catch {
             print(error)
         }
     }
    
    //////////////////////////////////Table view functions ///////////////////////////////////////////////
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let item = items[indexPath.row] as! BucketListItem  // casting as my entity
        cell.textLabel?.text = item.text
        return cell
    }
        // function listen to click row  حساسة للنقر على الخلية -___-
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    //function for delete with swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
       // items.remove(at: indexPath.row)
        let item = items[indexPath.row] as! BucketListItem
        deleteItem(text : item.text! )
        tableView.reloadData()
    }
    

}

