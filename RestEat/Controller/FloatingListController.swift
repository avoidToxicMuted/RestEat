//
//  FloatingListController.swift
//  RestEat
//
//  Created by snoopy on 04/08/2021.
//

import UIKit
import MapKit
import FoursquareKit
import FloatingPanel

class FloatingListController: UIViewController ,FloatingPanelControllerDelegate , MKMapViewDelegate{
    
    @IBOutlet weak var checkHistory : UIButton!
    @IBOutlet weak var randomFindButton : UIButton!
    @IBOutlet weak var restaurantList   : UITableView!
    @IBOutlet weak var visualEffectView : UIVisualEffectView!
    
    typealias PanelDelegate = FloatingPanelControllerDelegate & UIGestureRecognizerDelegate
    
    lazy var fpcDelegate: PanelDelegate = (traitCollection.userInterfaceIdiom == .pad) ? FloatingPanelPadDelegate(owner: self) :FloatingPanelPhoneDelegate(owner: self)
    
    @IBAction func findRestuarant(_ Sender : UIButton){
        
        let fpc2 = FloatingPanelController()
        let number = Int.random(in: 0..<venues.count-2)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contentVC = storyboard.instantiateViewController(identifier: "detail_vc") as! detailViewController
        
        fpc2.delegate = fpcDelegate

        contentVC.venue = self.venues[number]
        contentVC.mapView = self.mapView
        contentVC.viewController = fpc2
        
        fpc2.set(contentViewController: contentVC)
//        fpc2.setAppearanceForPhone()
        fpc2.addPanel(toParent: (appDelegate.window?.rootViewController)! ,animated: true)
        let homeVC = appDelegate.window?.rootViewController as! homeViewController
        homeVC.fpc.hide(animated: true, completion: nil)

    }
    @IBAction func checkHistory(_ Sender : UIButton){
        
        let fpc3 = FloatingPanelController()
        let storyboard = UIStoryboard(name : "Main" , bundle: nil)
        let contentVC = storyboard.instantiateViewController(identifier: "history_vc") as! FloatingHistoryListController


        fpc3.delegate = fpcDelegate

        contentVC.viewController = fpc3

        fpc3.set(contentViewController: contentVC)
        fpc3.setAppearanceForPhone()
        fpc3.addPanel(toParent: (appDelegate.window?.rootViewController)! ,animated: true)
        let homeVC = appDelegate.window?.rootViewController as! homeViewController
        homeVC.fpc.hide(animated: true, completion: nil)
        
    }
    
    var venues: [Venue] = []
    var mapView : MKMapView? = nil
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var findButtonColor : UIColor? = nil
    var historyButtonColor : UIColor? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView?.delegate = self
        
        restaurantList.delegate = self
        restaurantList.dataSource = self
        
        randomFindButton.layer.masksToBounds = true
        randomFindButton.layer.cornerRadius = 8.0
        
        checkHistory.layer.masksToBounds = true
        checkHistory.layer.cornerRadius = 8.0
        
        findButtonColor = randomFindButton.backgroundColor
        historyButtonColor = checkHistory.backgroundColor
        
    }
    
    
}


//MARK: - Delegate

extension FloatingListController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Near By : "
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fpc2 = FloatingPanelController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contentVC = storyboard.instantiateViewController(identifier: "detail_vc") as! detailViewController
        
    
        fpc2.delegate = fpcDelegate

        contentVC.viewController = fpc2
        contentVC.venue = self.venues[indexPath.row]
        contentVC.mapView = self.mapView
    
        fpc2.set(contentViewController: contentVC)
//        fpc2.setAppearanceForPhone()
        fpc2.addPanel(toParent: (appDelegate.window?.rootViewController)! ,animated: true)
        let homeVC = appDelegate.window?.rootViewController as! homeViewController
        homeVC.fpc.hide(animated: true, completion: nil)
        
        tableView.deselectRow(at:indexPath, animated: true)
        
    }
    
}

//MARK: - DataSource

extension FloatingListController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! detailCell
        cell.venue = self.venues[(indexPath as NSIndexPath).row]
        return cell
        
    }
}


// MARK: - iPhone
class FloatingPanelPhoneDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
    unowned let owner: FloatingListController

    init(owner: FloatingListController) {
        self.owner = owner
    }

    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        switch newCollection.verticalSizeClass {
        case .compact:
            let appearance = vc.surfaceView.appearance
            appearance.borderWidth = 1.0 / owner.traitCollection.displayScale
            appearance.borderColor = UIColor.black.withAlphaComponent(0.2)
            vc.surfaceView.appearance = appearance
            return PanelPhoneLandscapeLayout()
        default:
            return PanelPhoneProtraitLayout()
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

class PanelPhoneLandscapeLayout: FloatingPanelLayout {
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

class PanelPhoneProtraitLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 325, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 280.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
    
}



// MARK: - iPad
class FloatingPanelPadDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
    unowned let owner: FloatingListController

    init(owner: FloatingListController) {
        self.owner = owner
    }

    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        if newCollection.horizontalSizeClass == .compact {
            fpc.surfaceView.containerMargins = .zero
            return FloatingPanelBottomLayout()
        }
        fpc.surfaceView.containerMargins = UIEdgeInsets(top: .leastNonzeroMagnitude,left: 16,bottom: 0.0,right: 0.0)
        return PanelPadLayout()
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

class PanelPadLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition  = .bottom
    let initialState: FloatingPanelState = .full
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 365.0, edge: .top, referenceGuide: .safeArea),
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





