//
// Created by Dossymkhan Zhulamanov on 31.07.2022.
//

protocol RemoteAPIRequestType {
    func getAllStocksList() async throws -> [SingleStockViewModel]
//    func fetchStockImageUrlString(for symbol: String) async throws -> String
}

@MainActor
struct RemoteAPIRequest: RemoteAPIRequestType {

    // MARK: - RemoteAPIRequestType
    func getAllStocksList() async throws -> [SingleStockViewModel] {
        var stockViewModels = [SingleStockViewModel]()
        let urlString = URLBuilder.getAllStocks.makeString()
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw "Invalid HttpResponseCode"
        }
        let dataResponse = try JSONDecoder().decode([StockDetails].self, from: data)
        let stocksDetailsList = dataResponse[..<25]
        let stockSymbolsList = stocksDetailsList.map {
            $0.title
        }

        let imageUrlStringsDict = try await fetchStockImageUrlStringsList(for: stockSymbolsList)
        let nonEmptyImageUrlStringsList = imageUrlStringsDict.filter {
            !$0.value.isEmpty
        }
        var descriptors = [Descriptor]()
        for (index, item) in nonEmptyImageUrlStringsList.enumerated() {
            print(item.value)
            descriptors.append(
                    Descriptor(
                            stockSymbol: item.key,
                            stockImageUrlString: nonEmptyImageUrlStringsList[item.key]!,
                            type: .image)
            )
        }

        let taskResultsDict = try await fetchGroupedStocksInfo(descriptors: descriptors)
        for item in taskResultsDict {
            switch item.value {
            case .image(let image):
                    stockViewModels.append(
                        SingleStockViewModel(title: item.key, subTitle: "123", logoImage: image)
                    )
            default:
                break
            }
        }
        return stockViewModels
    }

    fileprivate func fetchGroupedStocksInfo(descriptors: [Descriptor]) async throws -> [String: TaskResult] {
        try await withThrowingTaskGroup(of: (String, TaskResult).self, returning: [String: TaskResult].self) { group in
            for descriptor in descriptors {
                group.addTask { [self] in
                    switch descriptor.type {
                    case .image:
                        let (_, image) = try await self.fetchStockImageTuple(descriptor.stockImageUrlString)
                        return (descriptor.stockSymbol, TaskResult.image(image))
                    case .marketData:
                        let marketResponse = try await self.fetchMarketInfo(descriptor.stockSymbol)
                        return (descriptor.stockSymbol, TaskResult.marketData(marketResponse))
                    }
                }
            }
            return try await group.reduce(into: [:]) {
                $0[$1.0] = $1.1
            }
        }
    }

    fileprivate func getImagesListFrom(_ urlStrings: [String]) async throws -> [String: UIImage] {
        try await withThrowingTaskGroup(of: (String, UIImage).self, returning: [String: UIImage].self) { group in
            for imageString in urlStrings {
                group.addTask { [self] in
                    try await fetchStockImageTuple(imageString)
                }
            }
            return try await group.reduce(into: [:]) {
                $0[$1.0] = $1.1
            }
        }
    }

    fileprivate func fetchStockImageTuple(_ symbol: String) async throws -> (String, UIImage) {

        let symbolUrl = URL(string: symbol)!
        let (data, _) = try await URLSession.shared.data(from: symbolUrl)
        return (symbolUrl.absoluteString, UIImage(data: data)!)
    }

    func fetchStockImageUrlStringsList(for symbols: [String]) async throws -> [String: String] {
        try await withThrowingTaskGroup(of: (String, String).self, returning: [String: String].self) { group in
            for symbol in symbols {
                group.addTask {
                    try await fetchStockImageUrlString(for: symbol)
                }
            }
            return try await group.reduce(into: [:]) {
                $0[$1.0] = $1.1
            }
        }
    }

    func fetchStockImageUrlString(for symbol: String) async throws -> (String, String) {
        if symbol.isEmpty {
            return (symbol, "")
        }
        let urlString = URLBuilder.fetchImage(symbol).makeString()
        let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
        guard data.count > 2 else {
            return (symbol, "")
        }
        let dataResponse = try JSONDecoder().decode(LogoURLString.self, from: data)
        if dataResponse.logo.isEmpty {
            return (symbol, "")
        }
        return (symbol, dataResponse.logo)
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

    func fetchMarketInfoList(_ symbols: [String]) async throws -> [MarketInfoResponse] {
        try await withThrowingTaskGroup(of: MarketInfoResponse.self, returning: [MarketInfoResponse].self) { group in
            for symbol in symbols {
                group.addTask {
                    try await fetchMarketInfo(symbol)
                }
            }
            return try await group.reduce(into: []) {
                $0.append($1)
            }
        }
    }

    func fetchMarketInfo(_ symbol: String, numberOfDays: TimeInterval = 3) async throws -> MarketInfoResponse {
        let urlString = URLBuilder.fetchMarketData(symbol, numberOfDays).makeString()
        print(urlString)
        let dataResponse = try await makeRequest(using: URL(string: urlString)!, responseModel: MarketInfoResponse.self)
        return dataResponse!
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

enum MediaType {
    case image, marketData
}

struct Descriptor {
    let stockSymbol: String
    let stockImageUrlString: String
    let type: MediaType

    init(stockSymbol: String, stockImageUrlString: String, type: MediaType) {
        self.type = type
        self.stockSymbol = stockSymbol
        self.stockImageUrlString = stockImageUrlString
    }
}

enum TaskResult {
    case image(UIImage)
    case marketData(MarketInfoResponse)
}
