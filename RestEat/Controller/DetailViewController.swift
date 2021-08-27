//
//  DetailViewController.swift
//  RestEat
//
//  Created by snoopy on 05/08/2021.
//

import UIKit
import MapKit
import CoreData
import FoursquareKit
import FloatingPanel

class detailViewController: UIViewController , MKMapViewDelegate{

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var venue : Venue? = nil
    var mapView : MKMapView? = nil
    var context : AnyObject? = nil
    var viewController : FloatingPanelController? = nil
    
    
    @IBOutlet weak var infoTableView : UITableView!
    
    @IBOutlet weak var rateScore     : UILabel!
    @IBOutlet weak var venueName     : UILabel!
    @IBOutlet weak var venueCategory : UILabel!

    @IBOutlet weak var callButton     : UIButton!
    @IBOutlet weak var navigateButton : UIButton!
    
    @IBOutlet weak var rateIcon      : UIImageView!
    @IBOutlet weak var closeButton   : UIImageView!
    @IBOutlet weak var detailImage   : UIImageView!
    @IBOutlet weak var loadingImage  : UIImageView!
    @IBOutlet weak var loadingEffect : UIVisualEffectView!
    
    @IBAction func navigate(_ sender: UIButton) {
        getDirections()
        saveVenueToHistory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingImage.loadGif(name: "detailLoading")
        
        loadingEffect.backgroundColor = UIColor.clear.withAlphaComponent(0.8)
        
        getVenueDetail()
    
        infoTableView.dataSource = self
        
        rateIcon.image = UIImage(systemName: "star.fill")
        
        detailImage.layer.masksToBounds = true
        detailImage.layer.cornerRadius = 8.0
        detailImage.layer.shadowRadius = 8.0
        detailImage.layer.shadowOpacity = 0.2
        detailImage.layer.shadowOffset = CGSize(width: 0, height: 3)

        navigateButton.layer.masksToBounds = true
        navigateButton.layer.cornerRadius = 8.0
        
        let close = UITapGestureRecognizer(target: self, action: #selector(closeWindow))
        closeButton.addGestureRecognizer(close)
        closeButton.isUserInteractionEnabled = true
        closeButton.image = UIImage(systemName: "xmark.circle.fill")

        let call = UITapGestureRecognizer(target: self, action: #selector(handleCall))
        callButton.addGestureRecognizer(call)
        callButton.layer.masksToBounds = true
        callButton.layer.cornerRadius = 8.0
        
        mapView!.centerCoordinate = CLLocationCoordinate2D(latitude: (venue!.location?.coordinate!.latitude)!, longitude: (venue!.location?.coordinate!.longitude)!)
        
        
        
    }
    
    @objc func closeWindow()
    {
        viewController?.removePanelFromParent(animated: true)
        mapView!.removeOverlays(mapView!.overlays)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            let homeVC = appDelegate.window!.rootViewController as? homeViewController
            homeVC!.fpc.show(animated: true, completion: nil)
        }
    }
    
    @objc func handleCall() {
        guard let number = venue?.phone else {
            let alert = UIAlertController(title: "Unknow Number!", message: "This restaurant does not provide any phone number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                    case .default:
                    print("default")
                    
                    case .cancel:
                    print("cancel")
                    
                    case .destructive:
                    print("destructive")    
                }
            }))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func saveVenueToHistory(){
        context = appDelegate.persistentContainer.viewContext
        let newVenue = HistoryVenue(context: context as! NSManagedObjectContext)
        newVenue.venue_id = self.venue?.id
        newVenue.venue_name = self.venue?.name
        newVenue.venue_category = self.venue?.categoryName
        
        do{
            try context?.save()
        }catch{
            print("error : \(error)")
        }
        
    }
    
    //MARK: - Downlaod image data from the url
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            self.venue?.imageData = data

            DispatchQueue.main.async() { [weak self] in
                self!.detailImage.image = UIImage(data: data)
                self!.venueName.text = self!.venue?.name
                self!.venueCategory.text = self!.venue?.categoryName
                
                self!.loadingImage.removeFromSuperview()
                UIView.animate(withDuration: 0.5, animations: {
                    self!.loadingEffect.alpha = 0
                }) { _ in
                    self!.loadingEffect.removeFromSuperview()
                }
            }
        }
    }
    
    
    //MARK: - Foursquare kit request for detial info of venue
    func getVenueDetail(){
        self.venue?.detailInfo = true
        let auth = Authentification(clientId: "PTOSOZFGBEDLCKOBLPFYWNWRWAFQXOZPEZ25T5EKEVGW4P20", clientSecret: "B4GNDA5DUJNQWGWIQQFPNL11GA1OV3CM43D5NAWCOZAERZ0H")
        let client = foursquareClient(authentification: auth)

        client.venue.details(id: self.venue!.id).response
        { result in
        switch result {
        case .success(let data):
            print("venue detial : \(data)")
            let dataResponse = data.response.venue
            if let prefix = dataResponse.photos?.groups[0].items[0].prefix , let suffix = dataResponse.photos?.groups[0].items[0].suffix{
                let url = URL(string: prefix + "370x170" + suffix)
                self.downloadImage(from: url!)
            }

            if let phone = dataResponse.contact.phone{
                self.venue?.phone = phone
            }

            if let rating = dataResponse.rating as? Float{
                self.venue?.rating = rating
                DispatchQueue.main.async() { [weak self] in
                    self!.rateScore.text = String(format : "%.1f" , ((self!.venue?.rating)!/2))
                }
            }
        case .failure(let error):
          print("foursquare kit error : \(error)")
            }
        }
    }
    
    //MARK: - Map
    
    func getDirections() {
        self.mapView?.delegate = self
        let location: CLLocationCoordinate2D

        location = CLLocationCoordinate2D(latitude: (self.mapView?.userLocation.location?.coordinate.latitude)!, longitude: (self.mapView?.userLocation.location?.coordinate.longitude)!)
        
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error:", error.localizedDescription)
                    
                }
                return
            }
            for _ in response.routes {
                //let steps = route.steps
            }
            let route = response.routes[0]

            self.mapView!.addOverlay(route.polyline , level: .aboveRoads)
   
            self.mapView!.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: .init(top: 32, left: 32, bottom: 32, right: 32), animated: true)
        }
    }
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (venue!.location?.coordinate!.latitude)!, longitude: (venue!.location?.coordinate!.longitude)!))
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)

        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        return request
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else { fatalError("Polyline Renderer could not be initialized") }
        let renderer = MKPolylineRenderer(overlay: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.05882352941, green: 0.737254902, blue: 0.9764705882, alpha: 1)
        renderer.lineWidth = 4.0
        renderer.alpha = 1.0
        return renderer
    }

}

//MARK: - Datasource
extension detailViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address_cell") as! AddressCell
        cell.venue = self.venue
        return cell
        
    }
}




