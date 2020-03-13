//
//  HomeCollectionViewController.swift
//  ITI_IOS_Movies_App
//
//  Created by Muhammad El-Arabi on 3/12/20.
//  Copyright © 2020 Muhammad El-Arabi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class HomeCollectionViewController: UICollectionViewController {
    
    var mainMoviesArr : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        
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
        return mainMoviesArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        
        // Configure the cell
        let img : UIImageView = (cell.viewWithTag(5) as? UIImageView)!
        print(mainMoviesArr[indexPath.row].image)
        //        if mainMoviesArr[indexPath.row].image == nil {
        img.sd_setImage(with: URL(string: "\("https://image.tmdb.org/t/p/w185")  \(mainMoviesArr[indexPath.row].image)" ), completed: nil)
        //        }else{
        //            img.image = UIImage.init(named: "no_img_avail")
        //        }
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
    
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
        print(mainMoviesArr[indexPath.row].image)
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
                }
            //                print("Movies : \(movies[0].title)")
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
