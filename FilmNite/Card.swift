//
//  Card.swift
//  FilmNite
//
//  Created by Sarah O'Brien on 11/25/20.
//

import Foundation
import UIKit
import Combine

//dummy data for now, figure out how to implement existing data
struct Card: Identifiable{
    let id = UUID()
    let name:String
    let imageName: String
    let released: Int
    let bio: String


    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var degree: Double = 0.0
    
    
    static var data = MoviesToCards()
//        let urlYourURL = URL (string: @"home_new.png")
//        avatarImageView.loadurl(url: urlYourURL!)
        //MoviesToCards()
    
}
func MoviesToCards() -> [Card] {
    
    print(sessionMovieList.movieList)
    var cardArray = [Card]()
    for movie in sessionMovieList.movieList {
        //let urlYourURL = URL (string: movie.image)
        cardArray.append(Card(name: movie.title, imageName: "testSwipe", released: movie.released, bio: movie.synopsis))
    }
    print(cardArray)
    return cardArray
}
extension UIImageView {
    func loadurl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
