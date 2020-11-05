//
//  ViewController.swift
//  FilmNite
//
//  Created by user180592 on 10/29/20.
// this is a test from sarah
//test; Jack; V2
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var SessionID: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBAction func CreateSession(_ sender: Any) {
        let movieList = [Movie(ID: 100, title: "test title")]
        let user = User(username: "testing", movies: movieList)
        let userList = [user, user]
        let _ = Session(ID: "1111", users: userList, sessionMovies: movieList)
        
    }
    
    @IBAction func JoinExistingSession(_ sender: Any) {
    }
}

