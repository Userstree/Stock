//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//



protocol CancellableStocksFetchable {
    func fetchStocks<A: Decodable>(withQuery query: String, completion: @escaping ([A]) -> ())
}

final class CancellableStocksFetcher: CancellableStocksFetchable {
    private var currentSearchNetworkTask: URLSessionDataTask?
    private let networkingService: NetworkingService

    init(networkingService: NetworkingService = NetworkingApi()) {
        self.networkingService = networkingService
    }

    func fetchStocks<A: Decodable>(withQuery query: String, completion: @escaping ([A]) -> ()) {
        currentSearchNetworkTask?.cancel() 

        _ = currentSearchNetworkTask = networkingService.searchStocks(withQuery: query) { repos in
            completion(repos)
        }
    }
}