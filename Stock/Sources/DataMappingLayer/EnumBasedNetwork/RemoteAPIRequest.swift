//
// Created by Dossymkhan Zhulamanov on 31.07.2022.
//

protocol RemoteAPIRequestType {
    func getAllStocksList() async throws -> [SingleStockViewModel]
//    func fetchStockImageUrlString(for symbol: String) async throws -> String
}

@MainActor
struct RemoteAPIRequest: RemoteAPIRequestType {

    let stocksService = StocksService()

    // MARK: - RemoteAPIRequestType
    func getAllStocksList() async throws -> [SingleStockViewModel] {
        return try await stocksService.getAllStocksList()
    }

    func fetchStockPrice(for symbol: String) async throws -> Int {
        if symbol.isEmpty {
            return -1
        }
        let urlString = URLBuilder.fetchQuote(symbol).makeString()
        let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
        let dataResponse = try JSONDecoder().decode(QuoteResponse.self, from: data)
        return Int(dataResponse.currentPrice)
    }

}

enum MediaType {
    case marketData
}

struct Descriptor {
    let stockSymbol: String
//    let stockImageUrlString: String
    let type: MediaType

    init(stockSymbol: String, type: MediaType) {
        self.type = type
        self.stockSymbol = stockSymbol
//        self.stockImageUrlString = stockImageUrlString
    }
}

enum TaskResult {
    case market(MarketInfoResponse)
//    case marketData(MarketInfoResponse)
}
