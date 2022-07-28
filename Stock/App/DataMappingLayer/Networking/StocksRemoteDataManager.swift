//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//


final class StocksRemoteDataManager<A: Decodable>: StocksRemoteDataManagerProtocol {
    private let networkingService: CancellableStocksFetchable

    init(networkingService: CancellableStocksFetchable = CancellableStocksFetcher()) {
        self.networkingService = networkingService
    }

    func fetchStocks(for query: String, completion: @escaping ([A]) -> ()) {
//        networkingService.fetchStocks<A>(withQuery: query, completion: completion)
        networkingService.fetchStocks(withQuery: query, completion: completion)
    }
}
