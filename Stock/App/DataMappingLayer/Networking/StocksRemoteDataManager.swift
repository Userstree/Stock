//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//


final class StocksRemoteDataManager<A: Decodable>: StocksRemoteDataManagerProtocol {
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


enum RemoteAPI {
    case twelveData
    case finHub
}

extension RemoteAPI {
    var urlString: String {
        switch self {
        case .finHub: return "https://finnhub.io/api/v1"
        case .twelveData: return "https://api.twelvedata.com"
        }
    }
}

enum APIkeys {
    case twelveData
    case finHub
}

extension APIkeys {
    var stringValue: String {
        switch self {
        case .twelveData: return "&apikey=349fabdc272c4af5a5193f8a6f76eec6"
        case .finHub: return "&token=cbhd3eaad3i0blffqelg"
        }
    }
}