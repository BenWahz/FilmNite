//
//  SwipeHostView.swift
//  FilmNite
//
//  Created by Sarah O'Brien on 11/29/20.
//

import Foundation
import UIKit
import SwiftUI


class SwipeHostView : UIViewController{
    private var model = Card(name: "", imageName: "", released: 0, bio: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeView()
    
    }
}

private extension SwipeHostView{
    func addSwipeView(){
        let swipeView = SwipeView(model: model)
        let controller = UIHostingController(rootView: swipeView)
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            controller.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
