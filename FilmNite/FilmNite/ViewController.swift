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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var SessionID: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBAction func CreateSession(_ sender: Any) {
        let UName: String = UserName.text!
        let movieList = [Movie(ID: 100, title: "test title")]
        let user = User(username: UName, movies: movieList)
        let userList = [user, user]
        let _ = Session(ID: GenerateSessionID(length: 5), users: userList, sessionMovies: movieList)
        
    }
    
    @IBAction func JoinExistingSession(_ sender: Any) {
    }
    
    func GenerateSessionID(length: Int) -> String{
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}

