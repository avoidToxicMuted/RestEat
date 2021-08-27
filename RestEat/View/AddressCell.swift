//
//  AddressCell.swift
//  RestEat
//
//  Created by snoopy on 13/08/2021.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var street : UILabel!
    @IBOutlet weak var city : UILabel!
    @IBOutlet weak var state : UILabel!
    
    var venue : Venue? {
        didSet{
            self.street.text = venue?.location?.street
            self.city.text = venue?.location?.city
            self.state.text = venue?.location?.state
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
