//
//  ViewController.swift
//  FilmNite
//
//  Created by user180592 on 10/29/20.
// this is a test from sarah
//test; Jack; V2
import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
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
        
        pickerData = ["2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"]
    
    }
    
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
        //let UName: String = UserName.text!
        //let movieList = [Movie(ID: 100, title: "test title")]
        //let user = User(username: UName, movies: movieList)
        //let userList = [user, user]
        //let _ = Session(ID: GenerateSessionID(length: 5), users: userList, sessionMovies: movieList)
        
        getMovies()
        
        
    }
    
    
    @IBAction func JoinExistingSession(_ sender: Any) {
        //let UName: String = UserName.text!
        //let SessID: String = SessionID.text!
        //let movieList = [Movie(ID: 111, title: "another test title")]
        //let user = User(username: UName, movies: movieList)
        //let _ = addUserToSession(sessionID: SessID, user: user)
    }
    
    func GenerateSessionID(length: Int) -> String{
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}

