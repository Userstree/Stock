//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//

import Foundation

protocol LocalDataRepository {

    func fetchFavouriteStocks() -> [SingleStockViewModel]
}

class LocalDataRepositoryImpl: LocalDataRepository {

    // MARK: - Properties
    private var favoriteStocks: [SingleStockViewModel] = []

    func fetchFavouriteStocks() -> [SingleStockViewModel] {
        favoriteStocks
    }


    // MARK: - Persitence Operations
    //         NSFetchedResultsControllerDelegate
    func loadFavoriteStocks() {

    }


    // MARK: - Init
    init() {
        loadFavoriteStocks()
    }

}
