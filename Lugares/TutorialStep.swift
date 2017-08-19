//
//  TutorialStep.swift
//  Lugares
//
//  Created by Felipe Hernandez on 8/18/17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import Foundation
import UIKit

class TutorialStep : NSObject{

    var index = 0
    var heading = ""
    var content = ""
    var image: UIImage!
    
    init(index:Int, heading:String, content:String, image:UIImage){
        
        self.index = index
        self.heading = heading
        self.content = content
        self.image = image
        
    }
}
