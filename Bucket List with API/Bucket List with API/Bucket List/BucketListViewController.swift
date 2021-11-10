//
//  ViewController.swift
//  Bucket List
//
//  Created by administrator on 09/10/2021.
//

import UIKit

class BucketListViewController : UITableViewController , AddedItemCVDelegate {
    

    var tasksDiscribtion : [TaskResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettTasks()
    }
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let addItemTableVC = storyboard?.instantiateViewController(withIdentifier: "AddItemTableViewController") as! AddItemTableViewController
        addItemTableVC.delegate = self
        addItemTableVC.editType = "add"
        addItemTableVC.taskObject = nil
        self.navigationController?.pushViewController(addItemTableVC, animated: true)
    }
    
    ///////////////////////////////////api functions /////////////////////////////////////////
    func gettTasks(){
        TaskModel.getAllTasks { taskList, error in
            guard let taskArr = taskList else {
                print("no task found")
                return
            }
            self.tasksDiscribtion = taskArr
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    func deleteTask(idToRemove : Int){
       
        TaskModel.removeTasks(id: idToRemove, completionHandler: { response, error in
            if let response = response {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                print(response.objective)
            } else {
                print(error)
            }
        })
        
    }

    //////////////////////////////// delegate functions ////////////////////////////////////////////
    
    func itemSaved() {
             self.gettTasks()
            }

    
 //////////////////////////////////Table view functions//////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksDiscribtion.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = tasksDiscribtion[indexPath.row].objective
        return cell
    }
        // function listen to click row  حساسة للنقر على الخلية -___-
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addItemTableVC = storyboard?.instantiateViewController(withIdentifier: "AddItemTableViewController") as! AddItemTableViewController
        addItemTableVC.delegate = self
        addItemTableVC.editType = "edit" //  "هذا يحددلي اش الزر اللي انضغط لمن نضغط "حفظ""
        addItemTableVC.taskObject = tasksDiscribtion[indexPath.row] // ارسل التاسك بنفس نوع الستركت و بمعلوماتها كاملة عشان استدعي معلوماتها في الفيو الثاني
        
        self.navigationController?.pushViewController(addItemTableVC, animated: true)
        
    }
    
    //function for delete with swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.deleteTask(idToRemove: tasksDiscribtion[indexPath.row].id)
        print("delete \(indexPath)")
        self.gettTasks()
    }
    

}

