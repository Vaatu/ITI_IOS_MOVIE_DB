//
//  HomeCollectionViewController.swift
//  ITI_IOS_MOVIE_DB
//
//  Created by Muhammad El-Arabi on 3/13/20.
//  Copyright © 2020 Muhammad El-Arabi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData


class HomeCollectionViewController: UICollectionViewController {
    
    var reachability = Reachability()
    
    var mainMoviesArr : [Movie] = []
    
    var segueIndex = -1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
//            preferredUserInterfaceStyle = .dark
        } else {
            // Fallback on earlier versions
        }
        
        if reachability.isConnectedToNetwork() == true {
            getMovies()
        } else {
            getMoviesFromDB()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return  mainMoviesArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aCell", for: indexPath)
        
        // Configure the cell
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        if mainMoviesArr.count > 0{
            
            if mainMoviesArr[indexPath.row].image != "null" {
                imageView.sd_setImage(with: URL(string: "\("https://image.tmdb.org/t/p/w185")\(mainMoviesArr[indexPath.row].image)" ), completed: nil)
            }else{
                imageView.image = UIImage.init(named: "no_img_avail")
            }
        }
        
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     */
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
//        segueIndex = indexPath.row
//        performSegue(withIdentifier: "showMovieDetails", sender: self)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("pressed")
//        segueIndex = indexPath.row
//        performSegue(withIdentifier: "showMovieDetails", sender: self)
        let movieDetails = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetails") as! MovieDetails
        movieDetails.movie = mainMoviesArr[indexPath.row]
        self.navigationController?.pushViewController(movieDetails, animated: true)
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showMovieDetails" {
//            let MovieDetails = segue.destination as! MovieDetails
//            MovieDetails.movie = mainMoviesArr[segueIndex]
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func getMovies(){
        var movies : [Movie] = []
        AF.request("https://api.themoviedb.org/3/discover/movie?api_key=c8b0eb2f599e052e6d93b9ebacaa0b61&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1").responseJSON {
            response in
            switch response.result {
            case .success(let value) :
                let json = JSON(value)
                
                if let moviesArr = json["results"].toArrOf(type:Movie.self){
                    movies = moviesArr as! [Movie]
                    self.mainMoviesArr = movies
                    self.collectionView.reloadData()
                    self.saveMoviesToDB()
                }
                print("Loaded Online")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if reachability.isConnectedToNetwork() == true {
        }
        self.navigationController?.isNavigationBarHidden = false

    }
    func saveMoviesToDB(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext  = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "SavedMovie", in: manageContext)
        

        for m in mainMoviesArr {
        let movie = NSManagedObject(entity: entity!, insertInto: manageContext)
        
            movie.setValue(m.id, forKey: "mID")
            movie.setValue(m.overView, forKey: "mOverView")
            movie.setValue(m.vote_average, forKey: "mRating")
            movie.setValue(m.release_date, forKey: "mReleaseYear")
            movie.setValue(m.title, forKey: "mTitle")
            movie.setValue(m.image, forKey: "mImage")

            do {
                try manageContext.save()
                
            }catch let error{
                
                print(error)
            }
        }
        
    }
    func getMoviesFromDB(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext  = appDelegate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "SavedMovie")
        do {
            var moviesArray = [NSManagedObject]()
            
            moviesArray = try manageContext.fetch(fetchReq)
            print("\("COREDATA GET")\(moviesArray.count)")
            
            for obj in moviesArray {
                let movie : Movie = Movie()
                
                movie.id = obj.value(forKey: "mID") as! Int
                movie.overView = obj.value(forKey: "mOverView") as! String
                movie.vote_average = obj.value(forKey: "mRating") as! Double
                movie.release_date = obj.value(forKey: "mReleaseYear") as! String
                movie.title = obj.value(forKey: "mTitle") as! String
                movie.image = obj.value(forKey: "mImage") as! String
                mainMoviesArr.append(movie)
                print("Loaded from CoreData")
            }
            self.collectionView.reloadData()
        }catch let error{
            
            print (error)
            
        }
        
    }
}
