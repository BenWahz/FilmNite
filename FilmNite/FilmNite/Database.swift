//
//  Database.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import Firebase

var sessionMovieList = MovieList();
var ref: DatabaseReference!

func addUserToSession(sessionID: String, user: User) {
    ref = Database.database().reference()
    ref.child(sessionID).child(user.username).setValue(["initial": 0])
}

func updateUser(sessionID: String, user: User) {
    ref = Database.database().reference()
    var ct = 0
    for movie in user.movies {
        ref.child(sessionID).child(user.username).setValue([String(ct): movie.netflixid])
        ct += 1
    }
}

func createSession(sessionID: String, user: User, requestURL: String) {
    ref = Database.database().reference()
    /// NETFLIX API //////////////////////////////////////////////////////////////////////////////
    //var movieList = [Dictionary<String, String>]()
    let headers = [
        "x-rapidapi-key": "305c976e8bmshb63b13d0d6334c9p1aaa99jsn0c2f6eeefa67",
        "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com"
    ]
    //"https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Anew1000-!1900%2C2020-!0%2C5-!0%2C10-!0-!Movie-!English-!Any-!gt1-!%7Bdownloadable%7D&t=ns&cl=78&st=adv&ob=Relevance&p=1&sa=and"
    let request = NSMutableURLRequest(url: NSURL(string: requestURL)! as URL,
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
            // make sure we got data
              guard let responseData = data else {
                print("Error: did not receive data")
                return
              }
                let json = try? JSONSerialization.jsonObject(with: responseData, options: [])
                
                if let dictionary = json as? [String: Any] {
                    if let array = dictionary["ITEMS"] as? [Dictionary<String, String>] {
                        ref.child(sessionID).child("sessionMovies").setValue(array)
                        return
                    } else {
                        print("Error Accessing Items")
                    }
                }
        }
    })
    ref.child(sessionID).child(user.username).setValue(["initial": 0])
    ref.child(sessionID).child("commonMovies").setValue(["initial": 0])
    getSessionMovies(sessionID: sessionID)
    dataTask.resume()
}

func getSessionMovies(sessionID: String) {
    let ref = Database.database().reference(withPath: sessionID)
    ref.observe(.value, with: { snapshot in
        // This is the snapshot of the data at the moment in the Firebase database
        makeMovies(snapshot: snapshot)
    })
}

func makeMovies(snapshot: DataSnapshot) {
        var movies = [Movie]()
        if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
            for snap in snapshots {
                if let postDictionary = snap.value as? [Dictionary<String, String>] {
                    for movieDict in postDictionary {
                        let movie = Movie()
                        for (key, value) in movieDict {
                            if key == "netflixid" {
                                movie.netflixid = Int(value) ?? -1
                            } else if key == "title" {
                                movie.title = value
                            } else if key == "image" {
                                movie.image = value
                            } else if key == "synopsis" {
                                movie.synopsis = value
                            } else if key == "released" {
                                movie.released = Int(value) ?? -1
                            } else if key == "rating" {
                                movie.rating = value
                            }
                        }
                        movies.append(movie)
                    }
                }
            }
        }
    // Set global variable
    sessionMovieList.movieList = movies
}
