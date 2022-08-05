//
//  Candle+CoreDataProperties.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 05.08.2022.
//
//

import Foundation
import CoreData


extension Candle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candle> {
        return NSFetchRequest<Candle>(entityName: "Candle")
    }

    @NSManaged public var high: Double
    @NSManaged public var low: Double
    @NSManaged public var open: Double
    @NSManaged public var close: Double
    @NSManaged public var date: String?
    @NSManaged public var timeInterval: Double
    @NSManaged public var ofViewModel: FavoriteStockViewModel?

}

extension Candle : Identifiable {

}
