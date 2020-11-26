//
//  CardViewController.swift
//  FilmNite
//
//  Created by Sarah O'Brien on 11/24/20.
//


import UIKit
import CardSlider

struct Item: CardSliderItem{
    var image: UIImage
    var rating: Int?
    var title: String
    var subtitle: String?
    var description: String?

}


class CardViewController: UIViewController, CardSliderDataSource{
    @IBOutlet var startSwipeButton: UIButton!
    
    var data = [Item]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        startSwipeButton.backgroundColor = .link
        startSwipeButton.setTitleColor(.white, for: .normal)
        
        data.append(Item(image: UIImage(named: "testSwipe" )!,
                         rating: nil,
                         title: "test",
                         subtitle: "test",
                         description: "yayasf.jagkj"))
        
        data.append(Item(image: UIImage(named: "testSwipe" )!,
                         rating: nil,
                         title: "test",
                         subtitle: "test",
                         description: "yayasf.jagkj"))
        data.append(Item(image: UIImage(named: "testSwipe" )!,
                         rating: nil,
                         title: "test",
                         subtitle: "test",
                         description: "yayasf.jagkj"))
        
                
    }
    @IBAction func didTapButton(){
        let vc = CardSliderViewController.with(dataSource: self)
        vc.title = "MovieNite"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated:true)
    }

    
    func item(for index: Int) -> CardSliderItem {
        return data[index]
    }
    
    func numberOfItems() -> Int {
        return data.count //should be number of films in session
    }
    
}
