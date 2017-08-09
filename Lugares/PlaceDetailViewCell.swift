//
//  PlaceDetailViewCell.swift
//  Mis Recetas
//
//  Created by Felipe Hernandez on 08-07-17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit

class PlaceDetailViewCell: UITableViewCell {

    @IBOutlet var keyLabel: UILabel!    
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
