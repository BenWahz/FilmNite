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
        let url = "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Anew1000-!1900%2C2020-!0%2C5-!0%2C10-!0-!Movie-!English-!Any-!gt1-!%7Bdownloadable%7D&t=ns&cl=78&st=adv&ob=Relevance&p=1&sa=and"
        let UName: String = UserName.text!
        let user = User(username: UName)
        createSession(sessionID: GenerateSessionID(length: 5), user: user, requestURL: url)
    }
    
    
    @IBAction func JoinExistingSession(_ sender: Any) {
        let UName: String = UserName.text!
        let SessID: String = SessionID.text!
        //let movieList = [Movie(ID: 111, title: "another test title")]
        let user = User(username: UName)
        let _ = addUserToSession(sessionID: SessID, user: user)
    }
    
    func GenerateSessionID(length: Int) -> String{
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}

