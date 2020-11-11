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
        for movie in user.movies {
            ref.child(sessionID).child(user.username).setValue([String(ct): movie.ID])
            ct += 1
        }
    }
}

func addUserToSession(sessionID: String, user: User) {
    ref = Database.database().reference()
    ref.child(sessionID).child(user.username).setValue(["initial": 0])
}

func updateUser(sessionID: String, user: User) {
    ref = Database.database().reference()
    var ct = 0
    for movie in user.movies {
        ref.child(sessionID).child(user.username).setValue([String(ct): movie.ID])
        ct += 1
    }
}

func getMovies() {
    /// NETFLIX API //////////////////////////////////////////////////////////////////////////////
    let headers = [
        "x-rapidapi-key": "305c976e8bmshb63b13d0d6334c9p1aaa99jsn0c2f6eeefa67",
        "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com"
    ]

    let request = NSMutableURLRequest(url: NSURL(string: "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Anew1000-!1900%2C2020-!0%2C5-!0%2C10-!0-!Movie-!English-!Any-!gt1-!%7Bdownloadable%7D&t=ns&cl=78&st=adv&ob=Relevance&p=1&sa=and")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
        }
    })
    dataTask.resume()
    //return data
}
    

