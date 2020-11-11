//
//  Movie.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import UIKit

struct Movie: Codable {
    var netflixid: Int
    var title: String
    var image: String
    var synopsis: String
    var year: Int
    var rating: Float
}


//class Movie {
//    var ID: Int
//    var title: String = ""
//    var image: String = ""
//    var description: String = ""
//    var year: Int
//    var rating: Float
//
//    init(ID: Int, title: String, image: String, description: String,
//         year: Int, rating: Float) {
//        self.ID = ID
//        self.title = title
//        self.image = image
//        self.description = description
//        self.year = year
//        self.rating = rating
//    }
//}
