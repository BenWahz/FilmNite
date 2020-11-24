//
//  EnterSessionViewController.swift
//  FilmNite
//
//  Created by Jace on 11/24/20.
//

import Foundation
import UIKit

class EnterSessionViewController: UIViewController {
    
    @IBOutlet weak var SessionID: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
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
        let UName: String = UserName.text!
        let SessID: String = SessionID.text!
        if UName == "" {
            errorLabel.text = "Please enter username"
        } else if SessID == "" {
            errorLabel.text = "Please enter session ID"
        } else {
            let user = User(username: UName)
            addUserToSession(sessionID: SessID, user: user)
        }
    }
    
    func GenerateSessionID(length: Int) -> String{
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
