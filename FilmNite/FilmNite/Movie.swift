//
//  Movie.swift
//  FilmNite
//
//  Created by Jace on 10/29/20.
//

import Foundation
import UIKit

class Movie {
    var ID: Int
    var title: String = ""
    
    init(ID: Int, title: String) {
        self.ID = ID
        self.title = title
    }
}
