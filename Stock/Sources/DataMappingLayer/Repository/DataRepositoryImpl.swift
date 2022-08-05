//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//

protocol DataRepository {
    var allStocks: ([SingleStockViewModel]) -> Void { get set }
    func getAllStocks() -> [SingleStockViewModel]
    func fetchFavouriteStocks() -> [SingleStockViewModel]
}

class DataRepositoryImpl: NSObject, DataRepository, NSFetchedResultsControllerDelegate {

    // MARK: - Properties aka Vars & Lets>
    private var managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    private let favoriteStocksProvider: FavoriteStockViewModelProvidable = FavoriteStocksPersistenceViewModelManager(with: managedContext,
                                                                                        fetchedResultsControllerDelegate: self)
    private var stocks: [SingleStockViewModel] = []
    private var favoriteStocks: [SingleStockViewModel] = []

    var allStocks: ([SingleStockViewModel]) -> Void = { _ in
    }

    // MARK: - Networking Operations
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

    func loadFavoriteStocks() {

    }

    // MARK: - Persitence Operations
    func fetchFavouriteStocks() -> [SingleStockViewModel] {
        favoriteStocks
    }

    // MARK: - Init

    override init() {
        runAsync()
        loadFavoriteStocks()
    }
}
