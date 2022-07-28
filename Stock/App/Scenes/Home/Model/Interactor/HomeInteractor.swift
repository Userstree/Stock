//
//  HomeInteractor.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

class HomeInteractor: HomeInteractorInputType {

    // MARK: - Dependencies
    private let dataManager: StocksRemoteDataManager<StocksListDetails>
    private let validator = ThrottledTextValidator()

    // MARK: HomeInteractorInputType Properties
    weak var presenter: HomeInteractorOutputType?

    // MARK: - Init
    init(dataManager: StocksRemoteDataManager<StocksListDetails> = StocksRemoteDataManager<StocksListDetails>()) {
        self.dataManager = dataManager
    }

    // MARK: - HomeInteractorInputType Protocol
    func fetchStocks(for query: String) {
        if query.isEmpty {
            startFetching(for: "aapl")
        } else {
            validator.validate(query: query) { [weak self] query in
                guard let strongSelf = self,
                      let query = query else { return }
                strongSelf.startFetching(for: query)
            }
        }
    }

    func fetchInitialStocks() {
        startFetching(for: "")
    }

    private func startFetching(for query: String) {
        dataManager.fetchStocks(for: query) { [weak self] stockDetailsList in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.didRetrieveStocksList(stockDetailsList.data)
        }
    }
}
