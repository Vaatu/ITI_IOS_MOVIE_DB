//
//  Trailers.swift
//  ITI_IOS_MOVIE_DB
//
//  Created by Muhammad El-Arabi on 3/16/20.
//  Copyright © 2020 Muhammad El-Arabi. All rights reserved.
//

import Foundation
import SwiftyJSON
class Trailers : JSONable{
    var trail : String
    
    required init?(parameter: JSON) {
        trail = parameter["key"].stringValue
    }
    
    init() {
        trail = ""
    }
    
    
}
