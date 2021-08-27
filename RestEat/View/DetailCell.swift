//
//  DetailCell.swift
//  RestEat
//
//  Created by snoopy on 04/08/2021.
//

import UIKit
import CoreLocation

class detailCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView : UIImageView!
    
    @IBOutlet weak var titleLabel    : UILabel!
    @IBOutlet weak var subTitleLabel : UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var imageURL : URL? = nil
    var homeVC : homeViewController? = nil
    var userCoordinate : CLLocationCoordinate2D? = nil
    
    var venue: Venue? {
        didSet {
            if (appDelegate.window?.rootViewController as? homeViewController) != nil{
                let currentLocation = CLLocation(latitude : userCoordinate!.latitude ,longitude : userCoordinate!.longitude)
                let destinationLocation = CLLocation(latitude: (venue?.location?.coordinate!.latitude)!, longitude: (venue?.location?.coordinate!.longitude)!)
                
                if let categoryName = venue?.categoryName.description {
                    print((Float(currentLocation.distance(from: destinationLocation)))/1000)
                    self.subTitleLabel?.text = categoryName + " . " + String(format : "%.1f" , (Float(currentLocation.distance(from: destinationLocation)))/1000) + " KM"
                }
            }         
            if let title = venue?.name {
                self.titleLabel?.text = "\(title)"
            }
            if let category = venue?.categoryName as? String{
                if category == "Chinese" || category == "chinese" || category == "Asian"{
                    self.iconImageView.image = UIImage(named: "chinese")
                }
                else if category == "Malay" || category == "malay"{
                    self.iconImageView.image = UIImage(named: "malay")
                }
                else if category == "indian" || category == "Indian"{
                    self.iconImageView.image = UIImage(named: "indien")
                }
                else if category == "Fast Food" || category == "Burgers" || category == "Wings"{
                    self.iconImageView.image = UIImage(named: "burger")
                }
                else if category == "Café" || category == "Cafe"{
                    self.iconImageView.image = UIImage(named: "cafe")
                }
                else if category == "Thai" || category == "thai"{
                    self.iconImageView.image = UIImage(named: "thai")
                }
                else if category == "Food Truck" || category == "food truck"{
                    self.iconImageView.image = UIImage(named: "food-truck")
                }
                else{
                    self.iconImageView.image = UIImage(named: "food")
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        homeVC = self.appDelegate.window?.rootViewController as? homeViewController
        userCoordinate = (homeVC?.mapView.userLocation.coordinate)!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
