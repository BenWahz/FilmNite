//
//  Database.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import Firebase

var sessionMovieList = MovieList()
var commonMovieList = MovieList()
var completedLoad = false
//var ref: DatabaseReference!

func checkIfSessionExists(sessionID: String!) {
    ref = Database.database().reference()
    ref.observeSingleEvent(of: .value, with:{ (snapshot) in
        if snapshot.hasChild(sessionID){
            //exists = true
            print(sessionID + " true - session exists")
            ///let user = User(username: UName)
            //addUserToSession(sessionID: sessi, user: user)
            //self.performSegue(withIdentifier: "joinSessionSegue", sender: self)
            
        } else {
            //exists = false
            print(sessionID + " False - session DOES NOT exist")
            //self.errorLabel.text = "Session Does not exist"
        }
    })
}

func addUserToSession(sessionID: String, user: User) {
    ref = Database.database().reference()
    ref.child(sessionID).child(user.username)
    getSessionMovies(sessionID: sessionID)
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
            print(error!)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse!)
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
    ref.child(sessionID).child(user.username)
    ref.child(sessionID).child("commonMovies")
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
    completedLoad = true
    print("1")
}

func addUserMovie(movie: Movie, sessionID: String, user: User) {
    ref.child(sessionID).child(user.username).setValue([String(movie.netflixid): movie.netflixid])
    checkIfCommonMovie(movie: movie, SessID: sessionID, UName: user.username)
}

func checkIfCommonMovie(movie: Movie, SessID: String, UName: String) {
    ref.child(SessID).child(UName).observeSingleEvent(of: .value, with: { (snapshot) in
        // need way to chack all users movies
        if snapshot.hasChild(String(movie.netflixid)) {
            
        } else {
            print(SessID + "False - session DOES NOT exist")
        }
    })
}

func addCommonMovie(movieID: Int, sessionID: String, username: String) {
    ref.child(sessionID).child(username).setValue([String(movieID): movieID])
}

func getCommonMovies(sessionID: String) {
    let path = sessionID + "/commonMovies"
    let ref = Database.database().reference(withPath: path)
    ref.observe(.value, with: { snapshot in
        // This is the snapshot of the data at the moment in the Firebase database
        buildCommonMovieList(snapshot: snapshot)
    })
}

func buildCommonMovieList(snapshot: DataSnapshot) {
    var movies = [Int]()
    if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
        for snap in snapshots {
            if let postDictionary = snap.value as? [Dictionary<String, String>] {
                for movieDict in postDictionary {
                    for (key, value) in movieDict {
                        if key == "netflixid" {
                            movies.append(Int(value) ?? -1)
                        }
                    }
                }
            }
        }
    }
    // build global array of common movies
    for movieID in movies {
        for movie in sessionMovieList.movieList {
            if movie.netflixid == movieID {
                commonMovieList.movieList.append(movie)
            }
        }
    }
}

func returnSessionMovies() -> [Movie] {
    print("2")
    //print(sessionMovieList.movieList)
    return sessionMovieList.movieList
}
