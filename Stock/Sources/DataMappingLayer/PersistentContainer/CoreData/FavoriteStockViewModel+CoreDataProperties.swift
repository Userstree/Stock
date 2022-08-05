//
//  FavoriteStockViewModel+CoreDataProperties.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 05.08.2022.
//
//

import Foundation
import CoreData


extension FavoriteStockViewModel {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<FavoriteStockViewModel> {
        return NSFetchRequest<FavoriteStockViewModel>(entityName: "FavoriteStockViewModel")
    }

    @NSManaged public var currentPrice: Double
    @NSManaged public var logoImage: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var title: String?

    public var wrappedTitle: String {
        title ?? "Unknown title"
    }

    public var wrappedSubTitle: String {
        subTitle ?? "Unknown subTitle"
    }
    
    public var wrappedLogoImage: String {
        logoImage ?? "Unknown logoImage"
    }
    
    public var wrappedCurrentPrice: Double {
        currentPrice 
    }
}

extension FavoriteStockViewModel : Identifiable {

}
