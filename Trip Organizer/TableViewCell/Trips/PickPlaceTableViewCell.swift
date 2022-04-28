//
//  TripPlaceTableViewCell.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 28/04/22.
//

import UIKit

class PickPlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
