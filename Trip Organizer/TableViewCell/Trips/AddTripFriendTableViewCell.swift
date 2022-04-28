//
//  AddTripParticipantTableViewCell.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 27/04/22.
//

import UIKit

class AddTripFriendTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var participantNameLabel: UILabel!
    @IBOutlet weak var participantImageView: CircularImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
