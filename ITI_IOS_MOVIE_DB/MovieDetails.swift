//
//  MovieDetails.swift
//  ITI_IOS_MOVIE_DB
//
//  Created by Aly Ayoub on 3/13/20.
//  Copyright © 2020 Muhammad El-Arabi. All rights reserved.
//

import UIKit


class MovieDetails: UIViewController {


    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func btnReviews(_ sender: UIButton) {
    }
    
    var movie = Movie()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        } else {
            // Fallback on earlier versions
        }
        
        movieTitle.text = movie.title
        year.text = movie.release_date
        overview.text = movie.overView
        
        imageView.sd_setImage(with: URL(string: "\("https://image.tmdb.org/t/p/w185")\(movie.image)" ), completed: nil)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
