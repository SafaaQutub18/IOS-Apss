//
//  ViewController.swift
//  Sports and Players
//
//  Created by administrator on 26/10/2021.
//

import UIKit
import CoreData

class SportsViewController: UITableViewController ,imagePickerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    //context
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var currentCellindexPath : Int?
   // var selectedImage : UIImage?
    var sportList : [SportEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSport()
    }

    func imagePick(cellIndexPath : Int) {
        
        let imagePickerVC = UIImagePickerController()
               imagePickerVC.sourceType = .photoLibrary
               imagePickerVC.delegate = self // new
        
        currentCellindexPath = cellIndexPath
        DispatchQueue.main.async {
            self.present(imagePickerVC, animated: true)
        }
 }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)

        if let image = info[.originalImage] as? UIImage {
            let selectedImage = image
            addImageToEntity(id: currentCellindexPath!, selectedImage : selectedImage)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }
    }
}
////////////////////////////// data core functions///////////////////////////
extension SportsViewController {
    
    // the action of '+' button
    @IBAction func addSport(_ sender: UIBarButtonItem) {
  
           let alert = UIAlertController(title: "New Sport",
                                         message: "Add a new sport ",
                                         preferredStyle: .alert)
           
           alert.addTextField(configurationHandler: nil)
           
           let saveAction = UIAlertAction(title: "Save", style: .default)
           {
               _ in
               let textField = alert.textFields![0] // take the value of the first text field
               // add sport to data core
               let newSportEntry = SportEntity(context: self.managedObjectContext)
               newSportEntry.sportName = textField.text!
               newSportEntry.sportId = Int16(self.sportList.count)
               self.saveSport()
           }
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           alert.addAction(saveAction)
           alert.addAction(cancelAction)
           present(alert, animated: true, completion: nil)
           
       }
    
    func addImageToEntity(id: Int , selectedImage : UIImage){
        
        let oldSportItem = sportList[id]
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "SportEntity")
                 
                 
        let predcate = NSPredicate.init(format: "sportName = %@", oldSportItem.sportName!)

                   request.predicate = predcate
                 do {
                  //   try managedObjectContext.fetch(SportEntity.fetchRequest())
                     let result = try managedObjectContext.fetch(request).first
                     let sportItem = result as! SportEntity
                     
                     //convert and save image in data core
                     sportItem.sportImage = selectedImage.pngData()
                     saveSport()
                 }
        catch{
            print("can not save the image")
        }
        
    }
    func saveSport() {
        do {
            try managedObjectContext.save()
            print("Save successful")
        } catch {
            print("Error \(error)")
        }
        fetchSport()
    }
    
    func fetchSport() {
        do {
            sportList = try managedObjectContext.fetch(SportEntity.fetchRequest())
            print("Success")
        } catch {
            print("Error: \(error)")
        }
        tableView.reloadData()
    }
}
////////////////////////////////////////////table view functions////////////////////////////////////////////////
extension SportsViewController {
    
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! SportCustomCell
        //assign data to cell elements
        
        cell.sportNameLabel.text = sportList[indexPath.row].sportName
        cell.cellindexPath = indexPath.row
        if let selectedImg = sportList[indexPath.row].sportImage {
            cell.addImageButton.setBackgroundImage(UIImage(data: selectedImg), for: .normal)
            cell.addImageButton.setTitle("", for: .normal)
        }
        else{
            cell.addImageButton.setTitle("add image", for: .normal)
        }
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportList.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(sportList[indexPath.row])
        self.saveSport()
    }
    
    // function listen to click row  حساسة للنقر على الخلية -___-
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let playerVC = self.storyboard?.instantiateViewController(withIdentifier: "PlayersViewController") as! PlayersViewController
         playerVC.sport = sportList[indexPath.row]
         self.present(playerVC, animated: true, completion: nil)
         
     }
}


