//
//  Movie.swift
//  IOSMovieProj
//
//  Created by Muhammad El-Arabi on 3/6/20.
//  Copyright © 2020 Muhammad El-Arabi. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONable {
    init?(parameter: JSON)
}

class Movie : JSONable  {
    
    var title : String;
    var image : String;
    var vote_average : Double;
    var id : Int ;
    //    var genre_ids : [Int]
    var overView : String;
    var release_date : String;
    
    required init(parameter: JSON) {
        //        ID            = parameter["id"].stringValue
        //        name          = parameter["name"].stringValue
        id  = parameter["id"].intValue
        title = parameter["original_title"].stringValue
        image = parameter["poster_path"].stringValue
        vote_average = parameter["vote_average"].doubleValue
        //        genre_ids = parameter["id"].arrayValue as!
        overView = parameter["overview"].stringValue
        release_date = parameter["release_date"].stringValue
    }
    init() {
        id = 0
        title = ""
        image = ""
        vote_average = 0.0
        release_date = ""
        overView = ""
    }
    
    
}
extension JSON {
    func toArrOf<T> (type: T?) ->Any?{
        
        if let baseObj = type as? JSONable.Type {
            
            if self.type == .array {
                
                var arrObject: [Any] = []
                
                for obj in self.arrayValue {
                    let object = baseObj.init(parameter: obj)
                    arrObject.append(object!)
                }
                return arrObject
            }else{
                let object = baseObj.init(parameter: self)
                return object
            }
            
        }
        return nil
    }
    
}
