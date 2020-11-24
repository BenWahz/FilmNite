//
//  ViewController.swift
//  FilmNite
//
//  Created by user180592 on 10/29/20.

import UIKit



class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    //genre array
    var genres = ["Action", "Animated", "Comedy", "Drama", "Documentary", "Horror"]
    var myIndex = 0
    
    //genre table view
    //@IBOutlet weak var genreTable: UITableView!
    
    var rowsWhichAreChecked = [NSIndexPath]()
    
    
    
    
    //start date and end date selection
    @IBOutlet weak var startDate: UIPickerView!
    @IBOutlet weak var endDate: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
        
        
        self.startDate?.delegate = self
        self.startDate?.dataSource = self
        
        self.endDate?.delegate = self
        self.endDate?.dataSource = self
        
        pickerData = (1900...2020).map { String($0) }
    
    }
    
    //date range picker fucntions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
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
        // might need to move from "create session" button to after the creator selects movie filters
        createSession(sessionID: GenerateSessionID(length: 5), user: user, requestURL: url)
    }
    
    
    @IBAction func JoinExistingSession(_ sender: Any) {
        let UName: String = UserName.text!
        let SessID: String = SessionID.text!
        let user = User(username: UName)
        addUserToSession(sessionID: SessID, user: user)
    }
    
    func GenerateSessionID(length: Int) -> String{
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}


