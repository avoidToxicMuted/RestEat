//
//  HistoryVenue+CoreDataProperties.swift
//  
//
//  Created by snoopy on 15/08/2021.
//
//

import Foundation
import CoreData


extension HistoryVenue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryVenue> {
        return NSFetchRequest<HistoryVenue>(entityName: "HistoryVenue")
    }

    @NSManaged public var venue_id: String?
    @NSManaged public var venue_name: String?
    @NSManaged public var venue_category: String?

}
