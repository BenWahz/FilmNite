//
//  EnterSessionViewController.swift
//  FilmNite
//
//  Created by Jace on 11/24/20.
//

import Foundation
import UIKit
import Firebase
import SwiftUI

var ref: DatabaseReference!

class EnterSessionViewController: UIViewController {
    
    //test swipe button. use this for buttons later when swipe is working properly
   
    @IBSegueAction func swipeSegue(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwipeView())
    }
    @IBOutlet weak var SessionID: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
    }
    
    @IBAction func CreateSession(_ sender: Any) {
        let url = "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Anew1000-!1900%2C2020-!0%2C5-!0%2C10-!0-!Movie-!English-!Any-!gt1-!%7Bdownloadable%7D&t=ns&cl=78&st=adv&ob=Relevance&p=1&sa=and"
        let UName: String = UserName.text!
        if UName == "" {
            errorLabel.text = "Please enter username"
        } else {
            let user = User(username: UName)
            // might need to move from "create session" button to after the creator selects movie filters
            createSession(sessionID: GenerateSessionID(length: 5), user: user, requestURL: url)
        }
    }
    
    @IBAction func JoinExistingSession(_ sender: Any) {
            //ref: DatabaseReference!
            let UName: String = UserName.text!
            let SessID: String = SessionID.text!
            
            if UName == "" {
                errorLabel.text = "Please enter username"
            } else if SessID == "" {
                errorLabel.text = "Please enter session ID"
            }else{
                //checkIfSessionExists(sessionID: SessID)
                //var exists = false;
                ref = Database.database().reference()
                ref.observeSingleEvent(of: .value, with:{ (snapshot) in
                    if snapshot.hasChild(SessID){
                        //exists = true
                        print("true - session exist")
                        let user = User(username: UName)
                        addUserToSession(sessionID: SessID, user: user)
                        //self.performSegue(withIdentifier: "swipeSegue()", sender: self)
                        
                    }else{
                        //exists = false
                        print(SessID + "False - session DOES NOT exist")
                        self.errorLabel.text = "Session Does not exist"
                    }
                })
            }
                //        }else if checkIfSessionExists(sessionID: SessID) == true{
    //            let user = User(username: UName)
    //            addUserToSession(sessionID: SessID, user: user)
    //            performSegue(withIdentifier: "joinSessionSegue", sender: self)
    //        }
        }
    
    func GenerateSessionID(length: Int) -> String{
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
    
    

