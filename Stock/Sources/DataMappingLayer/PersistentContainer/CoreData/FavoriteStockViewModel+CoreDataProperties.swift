//
//  FavoriteStockViewModel+CoreDataProperties.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 05.08.2022.
//
//

import CoreData


extension FavoriteStockViewModel {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<FavoriteStockViewModel> {
        NSFetchRequest<FavoriteStockViewModel>(entityName: "FavoriteStockViewModel")
    }

    @NSManaged public var title: String
    @NSManaged public var subTitle: String
    @NSManaged public var logoImage: String
    @NSManaged public var currentPrice: Double
    @NSManaged public var candleSticks: Candle

}

extension FavoriteStockViewModel : Identifiable {

}
