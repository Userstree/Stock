//
//  HomeInteractor.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

class HomeInteractor: HomeInteractorInputType {

    // MARK: - Dependencies
    private let getAllDataManager: StocksRemoteDataManager<StockDetails>
//    private let searchManager: StocksRemoteDataManager<
    private let validator = ThrottledTextValidator()

    // MARK: HomeInteractorInputType Properties
    weak var presenter: HomeInteractorOutputType?

    // MARK: - Init
    init(getAllDataManager: StocksRemoteDataManager<StockDetails> = StocksRemoteDataManager<StockDetails>()
//         searchDataManager: StocksRemoteDataManager<
    ) {
        self.getAllDataManager = getAllDataManager
    }

    // MARK: - HomeInteractorInputType Protocol
    func fetchStocks(for query: String) {
        if query.isEmpty {
            startFetching(for: "appl")
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
        getAllDataManager.fetchStocks(for: query) { [weak self] stockDetailsList in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.didRetrieveStocksList(stockDetailsList)
        }
    }
}
