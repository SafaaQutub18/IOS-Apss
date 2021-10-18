//
//  ViewController.swift
//  TodoList App
//
//  Created by administrator on 13/10/2021.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController , AddedItemDelegate{
    
    var items : [ToDoListEntity] = []
    var indexPathId : Int16 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        readItem()
    }
    
    func AddItemPressed( controller: AddItemViewController, title: String, notes: String, date: String) {
        
        addItemToEntity( title: title, note: notes, date: date , checkMark: false)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addItemViewController = segue.destination as! AddItemViewController
        addItemViewController.delegate = self
    }
}
extension TodoListViewController{
    
    /////////////////////DataBase functions /////////////////////////////////
    
    func getUpdatedContext() -> NSManagedObjectContext? {
           let delegate = UIApplication.shared.delegate as! AppDelegate
           return delegate.persistentContainer.viewContext
       }
    //Read items from data base
           func readItem() {
               guard let context = getUpdatedContext() else {
                   return
               }
               let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ToDoListEntity")
               do {
                   let result = try context.fetch(request)
                   items = result as! [ToDoListEntity] // return the data that stored in DB as list
                   tableView.reloadData()
               } catch {
                   print("Read Error:\(error)")
               }
           }
    //Add items to data base
    func addItemToEntity(title :String ,note :String ,date :String , checkMark: Bool) {
                guard let context = getUpdatedContext() else {
                    return
                }
            
            let item = ToDoListEntity.init(context: context)
            item.title = title
            item.note =  note
            item.date = date
            item.checkMark = checkMark
            item.id = Int16(items.count)
        
                do {
                    try context.save()
                    items.append(item)
                    tableView.reloadData()
                } catch {
                    print("Error: \(error)")
                }
            }
    
    func updateItem( indexPath: Int){
          guard let context = getUpdatedContext() else {
              return
          }
          // Old text
        let oldItemText = items[indexPath]
          // read

        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ToDoListEntity")
          
          // I do not understand why we must wite the next line T__T
        let predcate = NSPredicate.init(format: "id = %d", oldItemText.id )
            request.predicate = predcate
          do {
              let result = try context.fetch(request).first
              let bucketListItem = result as! ToDoListEntity
              bucketListItem.checkMark.toggle()

              try context.save()
              readItem()
          } catch {
              print(" update faild \(error)")
          }
      }
}

extension TodoListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return items.count
     }
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomCellToDoList
         let item = items[indexPath.row]
         cell.titleLabel.text = item.title
         cell.noteLabel.text = item.note
         cell.dateLabel.text = item.date
         cell.checkMarkLabel.isHidden = !item.checkMark
         
         return cell
     }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
         // function listen to click row  حساسة للنقر على الخلية -___-
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathId = Int16(indexPath.row)
        updateItem(indexPath: indexPath.row )
     }
}

