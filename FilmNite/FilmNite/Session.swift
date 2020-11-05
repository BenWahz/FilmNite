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
    var masterMovies = [Movie]()
    
    init(ID: String, users: [User], masterMovies: [Movie]) {
        self.ID = ID
        self.users = users
        self.masterMovies = masterMovies
        createSession(sessionID: ID, users: users, masterMovies: masterMovies)
    }
    
}
