//
//  Place.swift
//  Lugares
//
//  Created by Felipe Hernandez on 8/7/17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import Foundation
import UIKit

class Place {
    var name = ""
    var type = ""
    var location = ""
    var telephone = ""
    var website = ""
    var image : UIImage!
    var rating = "rating"
    
    init(name: String, type: String, location: String,telephone: String, website : String, image: UIImage) {
        self.name = name
        self.type = type
        self.location = location
        self.telephone = telephone
        self.website = website
        self.image = image
    }
    
    init() {
        
    }
    
}
