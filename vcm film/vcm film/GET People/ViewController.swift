//
//  ViewController.swift
//  GET People
//
//  Created by administrator on 14/10/2021.
//

import UIKit

class GETPeopleViewController: UITableViewController {

    var people : [String] = []
    
     
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
                                      self.people.append(personDict["name"]! as! String)
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
        print(people.count)
        return people.count
    }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // Create a generic cell
           let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
           cell.textLabel?.text = people[indexPath.row]
           return cell
       }
}

