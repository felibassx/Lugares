//
//  Place.swift
//  Lugares
//
//  Created by Felipe Hernandez on 8/7/17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Place : NSManagedObject {
    
    @NSManaged var name : String
    @NSManaged var type : String
    @NSManaged var location : String
    @NSManaged var telephone : String?
    @NSManaged var website : String?
    @NSManaged var image : Data?
    @NSManaged var rating : String?
    
    
}
