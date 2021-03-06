//
//  SessionCreatorViewController.swift
//  FilmNite
//
//  Created by Jace on 11/24/20.
//

import Foundation
import UIKit

class SessionCreatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var numMovies: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //start date and end date selection
    @IBOutlet weak var startDate: UIPickerView!
    @IBOutlet weak var endDate: UIPickerView!
    
    //genre array
    var genres = ["Action", "Animated", "Comedy", "Drama", "Documentary", "Horror"]
    var myIndex = 0
    var rowsWhichAreChecked = [NSIndexPath]()
    var pickerData: [String] = [String]()
    
    @IBAction func Next(_ sender: Any) {
        let numMov: String = numMovies.text!
        if numMov == "" {
            errorLabel.text = "Specify number of movies"
        } else {
            performSegue(withIdentifier: "nextSegue", sender: nil)
            errorLabel.text = ""
        }
    }
        
    
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
        
        startDate.selectRow(120, inComponent: 0, animated: true)
        endDate.selectRow(120, inComponent: 0, animated: true)
        
        
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
    
}
