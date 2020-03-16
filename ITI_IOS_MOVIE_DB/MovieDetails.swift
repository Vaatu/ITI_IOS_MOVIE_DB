//
//  MovieDetails.swift
//  ITI_IOS_MOVIE_DB
//
//  Created by Aly Ayoub on 3/13/20.
//  Copyright © 2020 Muhammad El-Arabi. All rights reserved.
//

import UIKit
import Cosmos
import youtube_ios_player_helper

class MovieDetails: UIViewController {
    
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    
    @IBAction func btnReviews(_ sender: UIButton) {
    }
    
    @IBOutlet weak var youtubeplayer: YTPlayerView!
    
    
    var movie = Movie()
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        if #available(iOS 13.0, *) {
//            overrideUserInterfaceStyle = .dark
//        } else {
//            // Fallback on earlier versions
//        }
print(movie.id)
        youtubeplayer.load(withVideoId: "tXaVr1yTrQo")
        movieTitle.text = movie.title
        year.text = movie.release_date
        overview.text = movie.overView
        imageView.sd_setImage(with: URL(string: "\("https://image.tmdb.org/t/p/w185")\(movie.image)" ), completed: nil)
        ratingView.rating = movie.vote_average/2
        ratingView.settings.updateOnTouch = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
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
