//
//  HomeViewController.swift
//  RestEat
//
//  Created by snoopy on 04/08/2021.
//

import UIKit
import MapKit
import FloatingPanel

class homeViewController: UIViewController, MKMapViewDelegate , FloatingPanelControllerDelegate {

    @IBOutlet var mapView : MKMapView!
    @IBOutlet weak var loadingGif : UIImageView!
    @IBOutlet weak var visualEffect : UIVisualEffectView!
    
    typealias PanelDelegate = FloatingPanelControllerDelegate & UIGestureRecognizerDelegate

    lazy var fpcDelegate: PanelDelegate = (traitCollection.userInterfaceIdiom == .pad) ? HomePanelPadDelegate(owner: self) : HomePanelPhoneDelegate(owner: self)
    
    let fpc = FloatingPanelController()

    private let foursquareClient = FoursquareClient(clientID: "APOMVYKGKAABDLI3QNG5L5DKOPY1ZBS0ARITQWJCCT0TUFCV", clientSecret: "NA3HLMZCLH3Y2QK0WOFT4DYSFI2ZEHRS45XSJBPDG3TURIQP")
    private var coordinate: Coordinate?
    private var locationManager = LocationManager()
    private var venues: [Venue] = [] {
        didSet {
            
            fpc.delegate = fpcDelegate
            let storyboard      = UIStoryboard(name: "Main", bundle: nil)
            guard let contentVC = storyboard.instantiateViewController(identifier: "fpc_vc") as? FloatingListController else {return}

            contentVC.venues  = self.venues
            contentVC.mapView = self.mapView

            fpc.set(contentViewController: contentVC)

            fpc.addPanel(toParent: self , animated: true)
            fpc.setAppearanceForPhone()
            addMapAnnotations()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingGif.loadGif(name: "location")
        
        mapView.showsUserLocation = true
        
        locationManager.getPermission()
        locationManager.onLocationUpdate = { coordinate in
            self.coordinate = coordinate
            self.fetchData()
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01 ,longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), span: span)
            
            self.mapView.setRegion(region, animated: true)
            
            self.loadingGif.removeFromSuperview()
            UIView.animate(withDuration: 1.5, animations: {
                self.visualEffect.alpha = 0
            }) { _ in
                self.visualEffect.removeFromSuperview()
            }
        }
    }
    
    
    // MARK: - Fetch restaurant from Foursquare API
    
    func fetchData() {
        if let coordinate = coordinate {
            foursquareClient.fetchResturantsFor(coordinate, category: .food(nil)) { result in
                switch result {
                case .success(let venues):
                    self.venues = venues
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    // MARK: - Map View
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        var region = MKCoordinateRegion()
        
        region.center              = mapView.userLocation.coordinate
        region.span.latitudeDelta  = 0.01
        region.span.longitudeDelta = 0.01
        
        mapView.setRegion(region, animated: true)
    }
    
    func addMapAnnotations() {
            removeMapAnnotations()
            if venues.count > 0 {
                let annotations: [MKPointAnnotation] = venues.map { venue in
                    let point = MKPointAnnotation()
    
                    if let coordinate = venue.location?.coordinate {
                        point.title      = venue.name
                        point.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    }
    
                    return point
                }
    
                mapView?.addAnnotations(annotations)
            }
    }
    
    func removeMapAnnotations() {
        if mapView?.annotations.count != 0 {
            for annotation in mapView!.annotations {
                mapView?.removeAnnotation(annotation)
            }
        }
    }
    
    // MARK: - Search
    func updateSearchResults() {
        if let coordinate = coordinate {
            foursquareClient.fetchResturantsFor(coordinate, category: .food(nil), query: "Foods") { result in
                switch result {
                case .success(let venues):
                    self.venues = venues
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

//MARK: - Floating Panel Layout

class FloatingHomePanel: FloatingPanelLayout {
    let position: FloatingPanelPosition  = .bottom
    let initialState: FloatingPanelState = .tip

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 56.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 280.0, edge: .bottom, referenceGuide: .safeArea),
            .tip : FloatingPanelLayoutAnchor(absoluteInset: 60, edge: .bottom, referenceGuide: .safeArea),
        ]
    }

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}

extension FloatingPanelController {
    func setAppearanceForPhone() {
        let appearance = SurfaceAppearance()
        if #available(iOS 13.0, *) {
            appearance.cornerCurve = .continuous
        }
        appearance.cornerRadius    = 8.0
        appearance.backgroundColor = .clear
        surfaceView.appearance     = appearance
    }

}


// MARK: - iPhone
class HomePanelPhoneDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
    unowned let owner: homeViewController

    init(owner: homeViewController) {
        self.owner = owner
    }

    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        switch newCollection.verticalSizeClass {
        case .compact:
            let appearance = vc.surfaceView.appearance
            appearance.borderWidth = 1.0 / owner.traitCollection.displayScale
            appearance.borderColor = UIColor.black.withAlphaComponent(0.2)
            vc.surfaceView.appearance = appearance
            return HomePanelLandscapeLayout()
        default:
            return FloatingHomePanel()
        }
    }
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        if vc.isAttracting == false {
            let loc = vc.surfaceLocation
            let minY = vc.surfaceLocation(for: .full).y
            let maxY = vc.surfaceLocation(for: .tip).y
            vc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        }
    }
}

class HomePanelLandscapeLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition  = .bottom
    let initialState: FloatingPanelState = .full
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 69.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
    func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        if #available(iOS 11.0, *) {
            return [
                surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8.0),
                surfaceView.widthAnchor.constraint(equalToConstant: 291),
            ]
        } else {
            return [
                surfaceView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0),
                surfaceView.widthAnchor.constraint(equalToConstant: 291),
            ]
        }
    }
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}


// MARK: - iPad
class HomePanelPadDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
    unowned let owner: homeViewController

    init(owner: homeViewController) {
        self.owner = owner
    }

    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        if newCollection.horizontalSizeClass == .compact {
            fpc.surfaceView.containerMargins = .zero
            return FloatingPanelBottomLayout()
        }
        fpc.surfaceView.containerMargins = UIEdgeInsets(top: .leastNonzeroMagnitude,left: 16, bottom: 0.0, right: 0.0)
        return FloatingPanelPadLayout()
    }
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        if vc.isAttracting == false {
            let loc = vc.surfaceLocation
            let minY = vc.surfaceLocation(for: .full).y
            let maxY = vc.surfaceLocation(for: .tip).y
            vc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        }
    }
}

class FloatingPanelPadLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition  = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 32.0, edge: .top, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 69.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
    func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.leftAnchor),
            surfaceView.widthAnchor.constraint(equalToConstant: 375),
        ]
    }
}


