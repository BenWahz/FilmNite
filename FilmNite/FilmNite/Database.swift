//
//  Database.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import Firebase

var ref: DatabaseReference!
var MasterList = [Movie]()

func createSession(sessionID: String, users: [User], sessionMovies: [Movie]) {
    ref = Database.database().reference()
    var ct = 0
    for movie in sessionMovies {
        ref.child(sessionID).child("Session Movies").setValue([String(ct): movie.netflixid])
        ct += 1
    }
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
//new from henry
func parse(json:Data){
    
    let decoder = JSONDecoder()
    
    if let jsonMovies = try? decoder.decode(MovieList.self, from: json){
        print("PARSING")
        MasterList = jsonMovies.items
    }
    for movie in MasterList{
        print(movie.title)
    }
}
func getMovies() {
    /// NETFLIX API //////////////////////////////////////////////////////////////////////////////
    //var MovieList = [Movie]()
    let headers = [
        "x-rapidapi-key": "305c976e8bmshb63b13d0d6334c9p1aaa99jsn0c2f6eeefa67",
        "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com"
    ]

    let request = NSMutableURLRequest(url: NSURL(string: "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Anew1000-!1900%2C2020-!0%2C5-!0%2C10-!0-!Movie-!English-!Any-!gt1-!%7Bdownloadable%7D&t=ns&cl=78&st=adv&ob=Relevance&p=1&sa=and")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    
    
    
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let urlString = "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Anew1000-!1900%2C2020-!0%2C5-!0%2C10-!0-!Movie-!English-!Any-!gt1-!%7Bdownloadable%7D&t=ns&cl=78&st=adv&ob=Relevance&p=1&sa=and"
    
    
    let session = URLSession.shared
    var dataTree = Data()
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        
        
        
        do{
               dataTree = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Data
                parse(json: dataTree)
            } catch {
                fatalError("json error: \(error)")
            }
        if (error != nil) {
            print(error!)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse!)
        }
      
    })
//    if let url = URL(string: urlString){
//        if let data = try? Data(contentsOf: url){
//            print("should parse next")
//            parse(json: data)
//
//        }
//    }
    
    dataTask.resume()
    //print(dataTree)
}
    

