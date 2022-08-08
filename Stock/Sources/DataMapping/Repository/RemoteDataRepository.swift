//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//

protocol RemoteDataRepositoryType {
    // MARK: - Methods
    var allStocksCallBack: ([SingleStockViewModel]) -> Void { get set }
//    var stockSummaryCallBack:
    func loadViewModelsFromWeb()
}

final class RemoteDataRepository: RemoteDataRepositoryType {
    // MARK: - Properties aka Vars & Lets>
    private var stocks: [SingleStockViewModel] = []


    // MARK: - RemoteDataRepository Protocol
    func loadViewModelsFromWeb() {
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

    func loadSummary(for symbol: String) {
        Task{
            do {
//                let stockSummary = try await RemoteAPIRequest().
            } catch {
                print("error is ", error.localizedDescription)
            }
        }
    }

    var allStocksCallBack: ([SingleStockViewModel]) -> Void = { _ in

    }

}
