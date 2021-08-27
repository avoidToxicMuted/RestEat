//
//  historyCell.swift
//  RestEat
//
//  Created by snoopy on 15/08/2021.
//

import UIKit

class historyCell: UITableViewCell {
    
    @IBOutlet weak var venueName : UILabel!
    @IBOutlet weak var venueCategory : UILabel!
    @IBOutlet weak var venueIcon : UIImageView!
    @IBOutlet weak var deviceName : UILabel!
    
    var historyVenue : HistoryVenue?{
        didSet{
            self.venueName.text = historyVenue!.venue_name
            self.venueCategory.text = historyVenue!.venue_category
            self.deviceName.text = "Local : " + UIDevice.current.name
            
            if let category = historyVenue!.venue_category as? String{
                if category == "Chinese" || category == "chinese" || category == "Asian"{
                    self.venueIcon.image = UIImage(named: "chinese")
                }
                else if category == "Malay" || category == "malay"{
                    self.venueIcon.image = UIImage(named: "malay")
                }
                else if category == "indian" || category == "Indian"{
                    self.venueIcon.image = UIImage(named: "indien")
                }
                else if category == "Fast Food" || category == "Burgers" || category == "Wings"{
                    self.venueIcon.image = UIImage(named: "burger")
                }
                else if category == "Café" || category == "Cafe"{
                    self.venueIcon.image = UIImage(named: "cafe")
                }
                else if category == "Thai" || category == "thai"{
                    self.venueIcon.image = UIImage(named: "thai")
                }
                else if category == "Food Truck" || category == "food truck"{
                    self.venueIcon.image = UIImage(named: "food-truck")
                }
                else{
                    self.venueIcon.image = UIImage(named: "food")
                }
            }
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
