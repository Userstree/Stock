//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//

protocol RemoteDataRepository {
    var allStocksCallBack: ([SingleStockViewModel]) -> Void { get set }
    func getAllStocks() -> [SingleStockViewModel]
}

class RemoteDataRepositoryImpl: NSObject, RemoteDataRepository, NSFetchedResultsControllerDelegate {

    // MARK: - Properties aka Vars & Lets>
    private var managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    private lazy var favoriteStocksProvider: FavoriteStockViewModelProvidable = {
        let manager = FavoriteStocksPersistenceViewModelManager(with: managedContext, fetchedResultsControllerDelegate: self)
        return manager
    }()
    private var stocks: [SingleStockViewModel] = []


    // MARK: - RemoteDataRepository Protocol
    private func loadViewModelsFromWeb() {
        Task(priority: .userInitiated) {
            do {
                let stockViewModels = try await RemoteAPIRequest().getAllStocksList()
                self.allStocksCallBack(stockViewModels)
                self.stocks = stockViewModels
            } catch {
                print("error is ", error.localizedDescription)
            }
        }
    }

    func getAllStocks() -> [SingleStockViewModel] {
        stocks
    }

    var allStocksCallBack: ([SingleStockViewModel]) -> Void = { _ in

    }


    // MARK: - Init
    override init() {
        super.init()
        loadViewModelsFromWeb()
    }
}
