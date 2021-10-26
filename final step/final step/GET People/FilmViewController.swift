//
//  FilmViewController.swift
//  GET People
//
//  Created by administrator on 17/10/2021.
//

import UIKit

class FilmViewController: UITableViewController {

        var filmsTitle : [String] = []
        var releaseDate : [String] = []
        var director : [String] = []
        var openingCrawl : [String] = []
        
         
        override func viewDidLoad() {
                super.viewDidLoad()
            
            StarWarsModel.getAllFilms(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
                      data, response, error in
                          do {
                              // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                              if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                  if let results = jsonResult["results"] as? NSArray {
                                      for person in results {
                                          let personDict = person as! NSDictionary
                                          self.filmsTitle.append(personDict["title"]! as! String)
                                          
                                          self.director.append(personDict["director"]! as! String)
                                          
                                          self.openingCrawl.append(personDict["opening_crawl"]! as! String)
                                          
                                          self.releaseDate.append(personDict["release_date"]! as! String)
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
          
            return filmsTitle.count
        }
           
           override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               // Create a generic cell
               let cell = tableView.dequeueReusableCell(withIdentifier: "myCell2", for: indexPath)
               cell.textLabel?.text = filmsTitle[indexPath.row]
               return cell
           }
    
    
    // function listen to click row  حساسة للنقر على الخلية -___-
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     let peopleVC = self.storyboard?.instantiateViewController(withIdentifier: "FilmesDetailsViewController") as! FilmesDetailsViewController
                 
                 // send data to other view
     
     peopleVC.filmTitle = "film title : \(filmsTitle[indexPath.row])"
     peopleVC.director = "film director: \(director[indexPath.row])"
     peopleVC.openingCrawl = "film opening Crawl: \(openingCrawl[indexPath.row])"
     peopleVC.releaseDate = "film release date: \(releaseDate[indexPath.row])"
     
     self.present(peopleVC, animated: true, completion: nil) }
    }

