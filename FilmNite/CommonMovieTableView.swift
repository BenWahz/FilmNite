//
//  CommonMovieTableView.swift
//  FilmNite
//
//  Created by Sarah O'Brien on 12/1/20.
//

import Foundation
import UIKit

var myIndex = 0

class CommonMovieTableView: UITableViewController {
    
    var allMovies = [Movie]()
    
    @IBOutlet weak var sessionIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        sessionIDLabel.text = globalSessionID
        print("SessionID:" + globalSessionID)
        getSessionMovies(sessionID: globalSessionID)
        self.allMovies = sessionMovieList.movieList
        print(self.allMovies)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "viewDetails"?:
            // figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // get the item associated with this row and pass it along
                let movie = allMovies[row]
                let  detailViewController = segue.destination as! CommonMoviesDetailView
                detailViewController.movie = movie
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMovies.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if we want to add detail view for movies, its handled here
        myIndex = indexPath.row
        print("Selected")
        performSegue(withIdentifier: "viewDetails", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "commonMovieCell", for: indexPath)
        cell.textLabel?.text = allMovies[indexPath.row].title
        return cell
    }
    
}
