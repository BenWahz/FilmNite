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
class Card: ObservableObject{
    //let id = UUID()
    @Published var name:String
    @Published var imageName: String
    @Published var released: Int
    @Published var bio: String
    
    init(name: String, imageName: String, released: Int, bio: String){
        self.name = name
        self.imageName = imageName
        self.released = released
        self.bio = bio
    }
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var degree: Double = 0.0
    
//    static var data: [Card]{
//        [
//        Card(name: "Filler,", imageName: "testSwipe", released: 1999, bio: "I love trying to make this workpls work this is isarah making a really long test for this because i want to see how it will look"),
//        Card(name: "movie title, ", imageName: "testSwipe", released: 1999, bio: "I love trying to make 222this workpls work"),
//        Card(name: "another,", imageName: "testSwipe", released: 1999, bio: "I love trying to make 222this workpls work")
//        ]
//    }
}
