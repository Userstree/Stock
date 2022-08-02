//
// Created by Dossymkhan Zhulamanov on 31.07.2022.
//

protocol RemoteAPIRequestType {
    func getAllStocksList() async throws -> [SingleStockViewModel]
    func fetchStockImage(for symbol: String) async throws -> String
}

@MainActor
struct RemoteAPIRequest: RemoteAPIRequestType {

    // MARK: - RemoteAPIRequestType
    func getAllStocksList() async throws -> [SingleStockViewModel] {
        var stockViewModels = [SingleStockViewModel]()
        let urlString = URLBuilder.getAllStocks.makeString()
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw(RemoteAPIError.invalidHttpResponseCode)
        }
        let dataResponse = try JSONDecoder().decode([StockDetails].self, from: data)
        let stocksDetailsList = dataResponse.prefix(25)

        return try await withThrowingTaskGroup(of: (String).self, returning: [SingleStockViewModel].self) { (taskGroup) in
            for stock in stocksDetailsList {
                taskGroup.addTask {
                    try await fetchStockImage(for: stock.title)
                }
            }
            var imageStrings = [String]()
            for try await image in taskGroup {
                imageStrings.append(image)
            }
//            taskGroup.ca
//            var marketDataList = [MarketInfoResponse]()
//            for stock in stocksDetailsList {
//                taskGroup.addTask {
//                    try await fetchMarketInfo(stock.title)
//                }
//            }
//            for try await marketInfo in taskGroup {
//                marketDataList.append(marketInfo)
//            }
            for (index, item) in stocksDetailsList.enumerated() {
                stockViewModels.append(
                        SingleStockViewModel(
                                title: item.title,
                                subTitle: item.subTitle,
                                logoUrlString: imageStrings[index]
//                                currentPrice: marketDataList.map {Int($0.open)}[index]
                        ))
            }
            stockViewModels.forEach {
                print($0.title, " and ", $0.logoUrlString)
            }
            return stockViewModels
        }
    }

    func fetchStockPrice(for symbol: String) async throws -> Int {
        if symbol.isEmpty {
            return -1
        }
        let urlString = URLBuilder.fetchQuote(symbol).makeString()
        let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
        let dataResponse = try JSONDecoder().decode(QuoteResponse.self, from: data)
        return dataResponse.currentPrice
    }

    func fetchMarketInfo(_ symbol: String, numberOfDays: TimeInterval = 3) async throws -> MarketInfoResponse {
        let urlString = URLBuilder.fetchMarketData(symbol, numberOfDays).makeString()
        print(urlString)
        let dataResponse = try await makeRequest(using: URL(string: urlString)!, responseModel: MarketInfoResponse.self)
        return dataResponse!
    }

    func fetchStockImage(for symbol: String) async throws -> String {
        if symbol.isEmpty {
            return ""
        }
        let urlString = URLBuilder.fetchImage(symbol).makeString()
        let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
        guard data.count > 2 else {
            return ""
        }
        let dataResponse = try JSONDecoder().decode(TwelveDataImageResponse.self, from: data)
        if dataResponse.logo.isEmpty {
            return ""
        }
        return dataResponse.logo
    }

    func makeRequest<T: Decodable>(using url: URL, responseModel: T.Type) async throws -> T? {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard data.count > 2 else {
            return nil
        }
        let dataResponse = try JSONDecoder().decode(T.self, from: data)
        return dataResponse
    }

}




