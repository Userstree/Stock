//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//



protocol CancellableStocksFetchable {
    func fetchStocks<A: Decodable>(withQuery query: String, completion: @escaping ([A]) -> ())
    func searchStocks<A: Decodable>(withQuery query: String, completion: @escaping ([A]) -> ())
    func fetchStockimage<A: Decodable>(completion: @escaping (A) -> ())
}

final class CancellableStocksFetcher: CancellableStocksFetchable {
    private var currentSearchNetworkTask: URLSessionDataTask?
    private let networkingService: NetworkingService

    init(networkingService: NetworkingService = NetworkingApi()) {
        self.networkingService = networkingService
    }

    func fetchStocks<A: Decodable>(withQuery query: String, completion: @escaping ([A]) -> ()) {
        currentSearchNetworkTask?.cancel()
        if query.isEmpty {
            DispatchQueue.global().async { [weak self] in
                self?.networkingService.getAllStocksList { stocks in
                    completion(stocks)
                }
            }
        } else {

            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.networkingService.searchStocks(with: query) { stocks in
                    completion(stocks)
                }
            }
        }
    }

    func searchStocks<A: Decodable>(withQuery query: String, completion: @escaping ([A]) -> ()) {
        currentSearchNetworkTask?.cancel()
        _ = currentSearchNetworkTask = networkingService.searchStocks(with: query) { stocks in
            completion(stocks)
        }
    }

    func fetchStockimage<A: Decodable>(completion: @escaping (A) -> ()) {
        currentSearchNetworkTask?.cancel()

//        _ = currentSearchNetworkTask = networkingService
    }
}