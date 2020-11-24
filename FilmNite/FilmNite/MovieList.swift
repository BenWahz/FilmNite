//
//  MovieList.swift
//  FilmNite
//
//  Created by Jace on 11/19/20.
//

import Foundation

class MovieList {
    var movieList = [Movie]()

    init() {
        self.movieList = [Movie]()
    }

    init(movieList: [Movie]) {
        self.movieList = movieList
    }
}
