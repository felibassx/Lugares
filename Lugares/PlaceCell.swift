  //
//  PlaceCell.swift
//  Mis Recetas
//
//  Created by Felipe Hernandez on 05-07-17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var telephoneLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
