//
//  HomeInteractor.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomeInteractor: HomeInteractorInputType, @unchecked Sendable {

    // MARK: - Dependencies
    private let validator = ThrottledTextValidator()

    // MARK: HomeInteractorInputType Properties
    weak var presenter: HomeInteractorOutputType?

    // MARK: - Init
    init() {}

    // MARK: - HomeInteractorInputType Protocol
    func fetchStocks(for query: String) {
        if query.isEmpty {
            startFetchingStocksList(for: "appl")
        } else {
            validator.validate(query: query) { [weak self] query in
                guard let strongSelf = self,
                      let query = query
                else {
                    return
                }
                strongSelf.startFetchingStocksList(for: query)
            }
        }
    }

    func fetchInitialStocks() {
        Task {
            do {
                let stockViewModels = try await RemoteAPIRequest().getAllStocksList()
                presenter?.didRetrieveStocksList(stockViewModels)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func startFetchingStocksList(for query: String) {

    }

    private func startFetchingImageStrings(for query: String) {
//        twelveDataImageManager.searchStocks(for: "", completion: <#T##@escaping ([StockImageURLStr]) -> ()##@escaping ([Stock.StockImageURLStr]) -> ()#>)
    }

}



