//
//  Reviews.swift
//  ITI_IOS_MOVIE_DB
//
//  Created by Muhammad El-Arabi on 3/16/20.
//  Copyright © 2020 Muhammad El-Arabi. All rights reserved.
//

import Foundation
import SwiftyJSON


class Reviews :JSONable {
    
    var author : String
    var review : String
    
    required init?(parameter: JSON) {
        author = parameter["author"].stringValue
        review = parameter["content"].stringValue
    }
    init() {
        author = ""
        review = ""
    }
    
    
    
}
