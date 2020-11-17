//
//  Database.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import Firebase

var ref: DatabaseReference!

func createSession(sessionID: String, users: [User], requestURL: String) {
    ref = Database.database().reference()
    var ct = 0
    let sessionMovies = getMovies(requestURL: requestURL)
    //for movie in sessionMovies {
    ref.child(sessionID).child("Session Movies").setValue(sessionMovies)
        //ct += 1
    //}
    ct = 0
    for user in users {
        for movie in user.movies {
            ref.child(sessionID).child(user.username).setValue([String(ct): movie.netflixid])
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
        ref.child(sessionID).child(user.username).setValue([String(ct): movie.netflixid])
        ct += 1
    }
}

func getMovies(requestURL: String) -> [Dictionary<String, String>] {
    /// NETFLIX API //////////////////////////////////////////////////////////////////////////////
    var movieList = [Dictionary<String, String>]()
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
                        movieList = array
//                        for object in array {
                            //var movie = Movie()
//                            for (key, value) in object {
//                                if key == "netflixid" {
//                                    movie.netflixid = Int(value) ?? -1
//                                } else if key == "title" {
//                                    movie.title = value
//                                } else if key == "image" {
//                                    movie.image = value
//                                } else if key == "synopsis" {
//                                    movie.synopsis = value
//                                } else if key == "released" {
//                                    movie.released = Int(value) ?? -1
//                                } else if key == "rating" {
//                                    movie.rating = value
//                                }
                         //   }
//                            movieList.append(movie)
                     //   }
                    return
                    } else {
                        print("Error Accessing Items")
                    }
                }
        }
    })
    print("-----------------")
    print(movieList)
    return movieList
    dataTask.resume()
}
