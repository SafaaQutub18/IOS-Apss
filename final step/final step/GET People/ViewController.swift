//
//  ViewController.swift
//  GET People
//
//  Created by administrator on 14/10/2021.
//

import UIKit

class GETPeopleViewController: UITableViewController {

    var peopleName : [String] = []
    var Gender : [String] = []
    var birth_year : [String] = []
    var mass : [String] = []
    
    
     
    override func viewDidLoad() {
            super.viewDidLoad()
        
        StarWarsModel.getAllPeople(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
                  data, response, error in
                      do {
                          // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                          if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                              if let results = jsonResult["results"] as? NSArray {
                                  for person in results {
                                      let personDict = person as! NSDictionary
                                      self.peopleName.append(personDict["name"]! as! String)
                                      self.Gender.append(personDict["gender"]! as! String)
                                      self.birth_year.append(personDict["birth_year"]! as! String)
                                      self.mass.append(personDict["mass"]! as! String)
                                      
                                      
                                      
                                  }
                              }
                          }
                          DispatchQueue.main.async {
                              self.tableView.reloadData()
                          }
                      } catch {
                          print("Something went wrong")
                      }
              })
          }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(peopleName.count)
        return peopleName.count
    }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // Create a generic cell
           let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
           cell.textLabel?.text = peopleName[indexPath.row]
           return cell
       }
    
    // function listen to click row  حساسة للنقر على الخلية -___-
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     let peopleVC = self.storyboard?.instantiateViewController(withIdentifier: "PeopleDetailsViewController") as! PeopleDetailsViewController
                 
                 // send data to other view
     print(peopleName[indexPath.row])
     peopleVC.name = "person name: \(peopleName[indexPath.row])"
     peopleVC.gender = "person gender: \(Gender[indexPath.row])"
     peopleVC.birthYear = "person birth year: \(birth_year[indexPath.row])"
     peopleVC.mass = "person mass: \(mass[indexPath.row])"
     
     self.present(peopleVC, animated: true, completion: nil) }
}

