//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//

protocol DataRepository {
    var allStocks: ([SingleStockViewModel]) -> Void { get set }
    func getAllStocks() -> [SingleStockViewModel]
    func favouriteStocks() -> [SingleStockViewModel]
}

class DataRepositoryImpl: DataRepository {

    private var fav: FavoriteStockViewModelProvidable = FavoriteStockViewModelProvider(with: <#T##NSManagedObjectContext##CoreData.NSManagedObjectContext#>,
            fetchedResultsControllerDelegate: <#T##NSFetchedResultsControllerDelegate##CoreData.NSFetchedResultsControllerDelegate#>)
    private var stocks: [SingleStockViewModel] = []
    private var favoriteStocks: [SingleStockViewModel] = []
    var allStocks: ([SingleStockViewModel]) -> Void = { _ in
    }

    init() {
        runAsync()
    }

    func runAsync() {
        Task(priority: .userInitiated) {
            do {
                let stockViewModels = try await RemoteAPIRequest().getAllStocksList()
                self.allStocks(stockViewModels)
                self.stocks = stockViewModels
            } catch {
                print("error is ", error.localizedDescription)
            }
        }
    }

    func getAllStocks() -> [SingleStockViewModel] {
        stocks
    }


    func favouriteStocks() -> [SingleStockViewModel] {
        favoriteStocks
    }

}
