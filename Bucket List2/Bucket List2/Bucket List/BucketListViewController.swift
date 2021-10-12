//
//  ViewController.swift
//  Bucket List
//
//  Created by administrator on 09/10/2021.
//

import UIKit

class BucketListViewController : UITableViewController , AddedItemCVDelegate {
    

    var items = ["walk", "eat" , "ride", "load" , "reed"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
      //  if segue.identifier == "AddItemSegue" {
        let navigationController = segue.destination as! UINavigationController
        let addItemTableVC = navigationController.topViewController as! AddItemTableViewController
        addItemTableVC.delegate = self
            
        if sender is NSIndexPath {
            let indexPath = sender as! NSIndexPath 
            // send the data (clicked item) to AddItemTableViewController to edit it
           
            let item = items[indexPath.row]
            addItemTableVC.item = item
            addItemTableVC.indexPath = indexPath
        }
    }
    
    func itemSaved(by controller: AddItemTableViewController , with text : String , at indexPath : NSIndexPath?) {
        if let ip = indexPath { // check if we send the indexpath that mean we want to edit the item
            items[ip.row] = text
        }
        else{
            items.append(text)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
              
            }
            
    func cancelBtttonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
        // function listen to click row  حساسة للنقر على الخلية -___-
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    //function for delete with swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("delete \(indexPath)")
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    

}

