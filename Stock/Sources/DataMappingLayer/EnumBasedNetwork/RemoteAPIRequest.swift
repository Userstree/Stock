//
// Created by Dossymkhan Zhulamanov on 31.07.2022.
//

protocol RemoteAPIRequestType {
    func getAllStocksList() async throws -> [SingleStockViewModel]
    func fetchStockImage(for symbol: String) async throws -> String
}


struct RemoteAPIRequest: RemoteAPIRequestType {

    // MARK: - RemoteAPIRequestType
    @MainActor func getAllStocksList() async throws -> [SingleStockViewModel] {
        var stockViewModels = [SingleStockViewModel]()
        let urlString = URLBuilder.getAllStocks.makeString()
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw "Invalid HttpResponseCode"
        }
        let dataResponse = try JSONDecoder().decode([StockDetails].self, from: data)
        let stocksDetailsList = dataResponse.prefix(25)
        let stocksImagesURLStrings = stocksDetailsList.map { try await fetchStockImage(for: $0.title) }

        enum MediaType {
            case image, marketData
        }

        struct Descriptor {
            let stockSymbol: String
            let type: MediaType
        }

        enum TaskResult {
            case image(UIImage)
            case marketData(MarketInfoResponse)
        }

        return try await withThrowingTaskGroup(of: (String, UIImage).self, returning: [SingleStockViewModel].self) { (taskGroup) in
            for imageString in stocksImagesURLStrings {
                taskGroup.addTask { [self] in
                    try await fetchStockImageTuple(.init(string: imageString)!)
                }
            }

            var imageStrings = Set<String> = []
            var imagesQueue = ImagesQueue()

            for try await imageURLString in taskGroup {
                imageStrings.insert(imageURLString)
                Task.detached {
                    try await imagesQueue.process(fetchStockImageTuple(URL(string: imageURLString)!))
                }
            }
            for (index, item) in stocksDetailsList.enumerated() {
                stockViewModels.append(
                        SingleStockViewModel(
                                title: item.title,
                                subTitle: item.subTitle,
                                logoUrlString: imageStrings[index]
//                currentPrice: imagesQueue.finished[stockDetailsImageURLs[]]
                        ))
            }
            return stockViewModels
        }
    }

    fileprivate func fetchStockImageTuple(_ symbol: URL) async throws -> (String, UIImage) {
        if symbol.isEmpty {
            return []
        }

        return try await withThrowing
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




