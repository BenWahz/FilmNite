//
//  Movie.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import UIKit

//struct Movie: Codable {
//    var netflixid: Int
//    var title: String
//    var image: String
//    var synopsis: String
//    var year: Int
//    var rating: Float
//}

class Movie {
    var netflixid: Int
    var title: String = ""
    var image: String = ""
    var synopsis: String = ""
    var released: Int
    var rating: String

    init(netflixid: Int, title: String, image: String, synopsis: String,
         released: Int, rating: String) {
        self.netflixid = netflixid
        self.title = title
        self.image = image
        self.synopsis = synopsis
        self.released = released
        self.rating = rating
    }
    
    init() {
        self.netflixid = 0
        self.title = ""
        self.image = ""
        self.synopsis = ""
        self.released = 0
        self.rating = ""
    }
}
