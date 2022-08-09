//
// Created by Dossymkhan Zhulamanov on 03.08.2022.
//

protocol MarketDataServiceable {
    func processMarketInfoList(_ symbols: [String]) async throws -> [String: MarketInfoResponse]
    func fetchMarketInfo(_ symbol: String, numberOfDays: TimeInterval) async throws -> (String, MarketInfoResponse)
}

actor MarketDataService: MarketDataServiceable {

    var marketDataList = [MarketInfoResponse]()

    func processMarketInfoList(_ symbols: [String]) async throws -> [String: MarketInfoResponse] {
        try await withThrowingTaskGroup(of: (String, MarketInfoResponse).self, returning: [String: MarketInfoResponse].self) { group in
            for symbol in symbols {
                group.addTask { [unowned self] in
                    try await self.fetchMarketInfo(symbol)
                }
            }
            return try await group.reduce(into: [:]) {
                $0[$1.0] = $1.1
            }
        }
    }

    nonisolated func fetchMarketInfo(_ symbol: String, numberOfDays: TimeInterval = 3) async throws -> (String, MarketInfoResponse) {
        let urlString = URLBuilder.fetchMarketData(symbol, numberOfDays).makeString()
        print(urlString)
        let dataResponse = try await makeRequest(using: URL(string: urlString)!, responseModel: MarketInfoResponse.self)
        return (symbol, dataResponse!)
    }

    private func makeRequest<T: Decodable>(using url: URL, responseModel: T.Type) async throws -> T? {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard data.count > 2 else {
            return nil
        }
        let dataResponse = try JSONDecoder().decode(T.self, from: data)
        return dataResponse
    }

}
