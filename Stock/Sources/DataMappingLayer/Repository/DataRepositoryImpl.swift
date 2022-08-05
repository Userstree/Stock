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
    private lazy var favoriteStocksProvider: FavoriteStockViewModelProvidable = {
        let manager = FavoriteStocksPersistenceViewModelManager(with: managedContext, fetchedResultsControllerDelegate: self)
        return manager
    }()
    private var stocks: [SingleStockViewModel] = []
    private var favoriteStocks: [SingleStockViewModel] = []

    // MARK: - DataRepository Protocol
    func loadViewModelsFromWeb() {
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

    var allStocks: ([SingleStockViewModel]) -> Void = { _ in

    }

    // MARK: - Persitence Operations
    //         NSFetchedResultsControllerDelegate
    func loadFavoriteStocks() {
//        guard let favoriteStockViewModels = favoriteStocksProvider.fetchedResultsController.fetchedObjects else { return }
//        self.favoriteStocks = favoriteStockViewModels.map {
//            SingleStockViewModel(title: $0.title!,
//                    subTitle: $0.subTitle!,
//                    logoImage: $0.logoImage!,
//                    currentPrice: $0.currentPrice,
//                    candleSticks: $0.candleArray.map {
//                        CandleStick(high: $0.high, low: $0.low, open: $0.open, close: $0.close, date: Date(timeIntervalSince1970: TimeInterval($0.timeInterval)), timeInterval: $0.timeInterval) //MUST CHANGE DATE
//                    })
//        }
    }

    func fetchFavouriteStocks() -> [SingleStockViewModel] {
        favoriteStocks
    }

    // MARK: - Init
    override init() {
        super.init()
        loadViewModelsFromWeb()
        loadFavoriteStocks()
    }
}
