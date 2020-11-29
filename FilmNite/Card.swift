//
//  Card.swift
//  FilmNite
//
//  Created by Sarah O'Brien on 11/25/20.
//

import Foundation
import UIKit

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
    
    static var data: [Card]{
        [
        Card(name: "Filler,", imageName: "testSwipe", released: 1999, bio: "I love trying to make this workpls work this is isarah making a really long test for this because i want to see how it will look"),
        Card(name: "movie title, ", imageName: "testSwipe", released: 1999, bio: "I love trying to make 222this workpls work"),
        Card(name: "another,", imageName: "testSwipe", released: 1999, bio: "I love trying to make 222this workpls work")
        ]
    }
}
