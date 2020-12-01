//
//  joinSessionLobbyView.swift
//  FilmNite
//
//  Created by user180592 on 12/1/20.
//

import Foundation
import UIKit

class joinSessionLobbyView: UIViewController {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //getSessionMovies(sessionID: globalSessionID)
    }
    @IBAction func joinCardSwipe(_ sender: Any) {
        self.performSegue(withIdentifier: "toCardSwipe", sender: self)
    }
}
