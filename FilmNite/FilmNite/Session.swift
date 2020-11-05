//
//  Session.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import UIKit 

class Session {
    var ID = ""
    var users = [User]()
    var sessionMovies = [Movie]()
    
    init(ID: String, users: [User], sessionMovies: [Movie]) {
        self.ID = ID
        self.users = users
        self.sessionMovies = sessionMovies
        createSession(sessionID: ID, users: users, sessionMovies: sessionMovies)
    }
    
}
