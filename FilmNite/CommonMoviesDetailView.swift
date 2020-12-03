//
//  CommonMoviesDetailView.swift
//  FilmNite
//
//  Created by Ryan Brown on 12/2/20.
//

import UIKit

class CommonMoviesDetailView : UIViewController {
    
    var movie: Movie!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var synopsisField: UITextField!
    @IBOutlet weak var releasedField: UITextField!
    @IBOutlet weak var ratingField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleField.text = movie.title
        synopsisField.text = movie.synopsis
        releasedField.text = "\(movie.released)"
        ratingField.text = movie.rating
    }
    
}
