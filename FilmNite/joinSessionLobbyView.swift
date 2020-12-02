//
//  joinSessionLobbyView.swift
//  FilmNite
//
//  Created by user180592 on 12/1/20.
//

import Foundation
import UIKit


class joinSessionLobbyView: UIViewController{
    
    @IBAction func join(_ sender: UIButton) {
        performSegue(withIdentifier: "toCardSwipe", sender: self)
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //getSessionMovies(sessionID: globalSessionID)
    }
//    @IBAction func joinCardSwipe(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "toCardSwipe", sender: self)
//    }
    
    
}
