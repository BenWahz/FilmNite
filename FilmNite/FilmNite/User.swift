//
//  Users.swift
//  FilmNite
//
//  Created by Jace on 11/5/20.
//

import Foundation
import UIKit

class User {
    var username = ""
    var movies = [Movie]()
    
    init(username: String, movies: [Movie]) {
        self.username = username
        self.movies = movies
    }
    
    func addToSession(user: User) {
        AddUserToSession(user: user)
    }
}
