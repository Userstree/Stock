//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//

protocol RemoteDataRepositoryType: Sendable {
    // MARK: - Methods
    var allStocksCallBack: ([SingleStockViewModel]) -> Void { get set }
    var searchedStockCallBack: ([SearchResult]) -> Void { get set }
    var companySummaryCallBack: (CompanySummary) -> Void { get set }
    func loadViewModelsFromWeb()
    func searchStock(for query: String)
    func loadSummary(for symbol: String)
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
                print("error is in loadViewModels: ", error.localizedDescription)
            }
        }
    }

    func searchStock(for query: String) {
        Task(priority: .userInitiated) {
            do {
                let searchResults = try await RemoteAPIRequest().searchForCompanyUsing(query: query)
                self.searchedStockCallBack(searchResults)
            } catch {
                print("error is in search stock: ", error.localizedDescription)
            }
        }
    }

    func loadSummary(for symbol: String) {
        print("load summary in Task")
        Task(priority: .userInitiated) {
            do {
                let summary = try await RemoteAPIRequest().getCompanySummary(for: symbol)
                self.companySummaryCallBack(summary)
            } catch {
                print("load summary error: ", error.localizedDescription)
            }
        }
    }

    var allStocksCallBack: ([SingleStockViewModel]) -> Void = { _ in
    }

    var companySummaryCallBack: (CompanySummary) -> () = { _ in }

    var searchedStockCallBack: ([SearchResult]) -> () = { _ in
    }
}
