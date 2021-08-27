//
//  FloatingHistoryListController.swift
//  RestEat
//
//  Created by snoopy on 15/08/2021.
//

import UIKit
import CoreData
import FloatingPanel

class FloatingHistoryListController: UIViewController {

    @IBOutlet weak var historyTableView : UITableView!
    @IBOutlet weak var closeButton : UIImageView!
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var viewController : FloatingPanelController? = nil
    
    private var venues = [HistoryVenue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        let close = UITapGestureRecognizer(target: self, action: #selector(closeWindow))
        closeButton.addGestureRecognizer(close)
        closeButton.image = UIImage(systemName: "xmark.circle.fill")
        
        getAllVenueFromLocal()
        
    }
    
    @objc func closeWindow() {
        viewController?.removePanelFromParent(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            let homeVC = appDelegate.window!.rootViewController as? homeViewController
            homeVC!.fpc.show(animated: true, completion: nil)
        }
    }
    
    func getAllVenueFromLocal() {
        do{
            self.venues = try context.fetch(HistoryVenue.fetchRequest())
            historyTableView.reloadData()
        }catch{
            print("error : \(error)")
        }
    }
}

//MARK: - Delegate
extension FloatingHistoryListController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        context.delete(venues[indexPath.row])
        do{
            try context.save()
            venues.remove(at: indexPath.row)
        }catch{
            print("error : \(error)")
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated: true)
    }
}

//MARK: - Datasource
extension FloatingHistoryListController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "history_cell" , for: indexPath) as! historyCell
        cell.historyVenue = self.venues[indexPath.row]
        return cell
    }
    
}
