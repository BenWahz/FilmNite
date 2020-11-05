//
//  Database.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import Firebase

var ref: DatabaseReference!

func createSession(sessionID: String, users: [User], sessionMovies: [Movie]) {
    ref = Database.database().reference()
    var ct = 0
    for movie in sessionMovies {
        ref.child(sessionID).child("Session Movies").setValue([String(ct): movie.ID])
        ct += 1
    }
    ct = 0
    for user in users {
        for movieID in user.movies {
            ref.child(sessionID).child(user.username).setValue([String(ct): movieID])
            ct += 1
        }
    }
}

func addUserToSession(sessionID: String, user: User) {
    ref.child(sessionID).child(user.username).setValue(["initial": 0])
}

func updateUser(sessionID: String, user: User) {
    var ct = 0
    for movieID in user.movies {
        ref.child(sessionID).child(user.username).setValue([String(ct): movieID])
        ct += 1
    }
}
