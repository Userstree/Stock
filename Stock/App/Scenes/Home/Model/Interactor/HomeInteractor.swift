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
    private let twelveDataImageManager: StocksRemoteDataManager<StockImageURLStr>
    private let validator = ThrottledTextValidator()

    // MARK: HomeInteractorInputType Properties
    weak var presenter: HomeInteractorOutputType?

    // MARK: - Init
    init(getAllDataManager: StocksRemoteDataManager<StockDetails> = StocksRemoteDataManager<StockDetails>(),
         twelveDataImageManager: StocksRemoteDataManager<StockImageURLStr> = StocksRemoteDataManager<StockImageURLStr>()
    ) {
        self.getAllDataManager = getAllDataManager
        self.twelveDataImageManager = twelveDataImageManager
    }

    // MARK: - HomeInteractorInputType Protocol
    func fetchStocks(for query: String) {
        if query.isEmpty {
            startFetchingStocksList(for: "appl")
        } else {
            validator.validate(query: query) { [weak self] query in
                guard let strongSelf = self,
                      let query = query else { return }
                strongSelf.startFetchingStocksList(for: query)
            }
        }
    }

    func fetchInitialStocks() {
        startFetchingStocksList(for: "")
    }

    private func startFetchingStocksList(for query: String) {
        getAllDataManager.fetchStocks(for: query) { [weak self] stockDetailsList in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.didRetrieveStocksList(stockDetailsList)
        }
    }

    private func startFetchingImageStrings(for query: String) {
//        twelveDataImageManager.searchStocks(for: "", completion: <#T##@escaping ([StockImageURLStr]) -> ()##@escaping ([Stock.StockImageURLStr]) -> ()#>)
    }

}



