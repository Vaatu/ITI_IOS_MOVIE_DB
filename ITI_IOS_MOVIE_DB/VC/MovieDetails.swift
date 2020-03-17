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
import CoreData

class MovieDetails: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var trailersimage: UIImageView!

    @IBAction func showTrailersBtn(_ sender: Any) {
        let trailersTV = self.storyboard?.instantiateViewController(withIdentifier: "TheTrailers") as! TrailersTableViewController
        
        trailersTV.movieID = movie.id
        self.navigationController?.pushViewController(trailersTV, animated: true)
    }
    @IBAction func btnReviews(_ sender: UIButton) {
                let reviewVC = self.storyboard?.instantiateViewController(withIdentifier: "reviewsVC") as! ReviewsTableViewController
        reviewVC.movieID = movie.id
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showReviews" {
//            let reviewsTV = segue.destination as! ReviewsTableViewController
//            reviewsTV.movieID = movie.id
//        }
//    }
    
    @IBAction func btnFavorite(_ sender: UIButton) {
        
        let favoriteMovie = NSEntityDescription.entity(forEntityName: "Favorited", in: context)
        favoriteMovie?.setValue(movieTitle.text, forKey: "title")
        do {
            try context.save()
        } catch  {
            print("Error Saving Favorite")
        }
        
    }
    
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if #available(iOS 13.0, *) {
        //            overrideUserInterfaceStyle = .dark
        //        } else {
        //            // Fallback on earlier versions
        //        }
        print(movie.id)
        trailersimage.image = UIImage.init(named: "video-active-512")
        movieTitle.text = movie.title
        year.text = movie.release_date
        overview.text = movie.overView
        imageView.sd_setImage(with: URL(string: "\("https://image.tmdb.org/t/p/w185")\(movie.image)" ), completed: nil)
        ratingView.rating = movie.vote_average/2
        ratingView.settings.updateOnTouch = false
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
