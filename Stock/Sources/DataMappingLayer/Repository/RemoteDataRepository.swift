//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//

protocol RemoteDataRepositoryType {
    // MARK: - Methods
    var allStocksCallBack: ([SingleStockViewModel]) -> Void { get set }
    func getAllStocks() -> [SingleStockViewModel]
}

final class RemoteDataRepository: RemoteDataRepositoryType {
    // MARK: - Properties aka Vars & Lets>
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
    init() {
        loadViewModelsFromWeb()
    }
}
