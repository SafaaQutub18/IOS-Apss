//
//  FilmesDetailsViewController.swift
//  GET People
//
//  Created by administrator on 20/10/2021.
//

import UIKit

class FilmesDetailsViewController: UIViewController {

    var filmTitle = ""
    var releaseDate = ""
    var director = ""
    var openingCrawl = ""
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var openingCrawlLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = filmTitle
        releaseDateLabel.text = releaseDate
        directorLabel.text = director
        openingCrawlLabel.text = openingCrawl
            // Do any additional setup after loading the view.
    }

}
