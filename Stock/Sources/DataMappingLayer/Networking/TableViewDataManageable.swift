//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//


final class TableViewDataManageable<A: Decodable> {
    private let networkingService: CancellableStocksFetchable

    init(networkingService: CancellableStocksFetchable = CancellableStocksFetcher()) {
        self.networkingService = networkingService
    }

    func fetchStocks(for query: String, completion: @escaping ([A]) -> ()) {
        networkingService.fetchStocks(withQuery: query, completion: completion)
    }

    func searchStocks(for query: String, completion: @escaping ([A]) -> ()) {
        networkingService.searchStocks(withQuery: query, completion: completion)
    }

    func getStockImage(completion: @escaping (A) -> ()) {
        networkingService.fetchStockimage(completion: completion)
    }
}
