//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//

import Foundation

protocol LocalDataRepositoryType {
    // MARK: - Methods
    func fetchFavouriteStocks() -> [SingleStockViewModel]
}

class LocalDataRepository: NSObject, LocalDataRepositoryType, NSFetchedResultsControllerDelegate {
    // MARK: - Properties
    private var managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    private lazy var favoriteStocksProvider: FavoriteStockViewModelProvidable = {
        let manager = FavoriteStocksPersistenceViewModelManager(with: managedContext, fetchedResultsControllerDelegate: self)
        return manager
    }()
    private var favoriteStocks: [SingleStockViewModel] = []
    func fetchFavouriteStocks() -> [SingleStockViewModel] {
        favoriteStocks
    }


    // MARK: - Persitence Operations
    //        NSFetchedResultsControllerDelegate
    func loadFavoriteStocks() {

    }


    // MARK: - Init
    override init() {
        super.init()
        loadFavoriteStocks()
    }

}
