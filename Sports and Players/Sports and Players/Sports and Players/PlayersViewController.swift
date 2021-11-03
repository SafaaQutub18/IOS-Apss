//
//  PlayersViewController.swift
//  Sports and Players
//
//  Created by administrator on 30/10/2021.
//

import UIKit
import CoreData

class PlayersViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    //context
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var sport : SportEntity?
    @IBOutlet weak var titleLabel: UILabel!
    var playersList : [PlayerEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        titleLabel.text = sport?.sportName

    }
    @IBAction func addPlayerButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New Player", message: "Add a new player",preferredStyle: .alert)
       
               
               alert.addTextField(configurationHandler: nil)
               alert.addTextField(configurationHandler: nil)
               alert.addTextField(configurationHandler: nil)
               
               let nameTextField = alert.textFields![0]
               let ageTextField = alert.textFields![1]
               let heightTextField = alert.textFields![2]
               
                nameTextField.placeholder = "Enter player name"
                ageTextField.placeholder = "Enter player age"
                heightTextField.placeholder = "Enter player height"
               
               let saveAction = UIAlertAction(title: "Save", style: .default) {
                   _ in
                   
                   let newPlayer = PlayerEntity(context: self.managedObjectContext)
                   newPlayer.playerName = nameTextField.text!
                   newPlayer.playerAge = ageTextField.text!
                   newPlayer.playerHeight = heightTextField.text!
                   DispatchQueue.main.async {
                   
                       newPlayer.player_sportRelationship?.sportName = self.sport?.sportName
                       
                       self.sport?.addToSport_playerRelationship(newPlayer)
                       self.tableView.reloadData()
                       self.savePlayer()
                   }
                 
               }
               
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               alert.addAction(saveAction)
               alert.addAction(cancelAction)
               present(alert, animated: true, completion: nil)

    }
    func savePlayer() {
            do {
                try managedObjectContext.save()
                print("Save successful")
            } catch {
                print("Error \(error)")
            }
            
        fetchPlayer()
        }
        
        func fetchPlayer() {
            do {
                playersList = try managedObjectContext.fetch(PlayerEntity.fetchRequest())
                print("Success")
            } catch {
                print("Error: \(error)")
            }
            tableView.reloadData()
        }
    
    // MARK: - Table view data source

}
extension PlayersViewController : UITableViewDataSource
{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
         return sport?.sport_playerRelationship?.count ?? 0
    }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        //assign data to cell elements
          let currentPlayer = (sport?.sport_playerRelationship?[indexPath.row] as! PlayerEntity)
         
          
          cell.textLabel?.text = "player name: " + currentPlayer.playerName! + " - age: " + currentPlayer.playerAge! + " - hieght: " + currentPlayer.playerHeight!
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(sport?.sport_playerRelationship?[indexPath.row] as! PlayerEntity)
        self.savePlayer()
    }
}
