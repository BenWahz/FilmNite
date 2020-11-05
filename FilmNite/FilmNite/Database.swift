//
//  Database.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import Firebase

var ref: DatabaseReference!

func createSession(sessionID: String, users: [User], masterMovies: [Movie]) {
    ref = Database.database().reference()
    ref.setValue([sessionID: array])
    for movie in masterMovies {
        ref.child(ID).child("Session Movies").setValue(["movieID": movie.ID])
    }
}

func AddUserToSession(user: User) {
    
}
