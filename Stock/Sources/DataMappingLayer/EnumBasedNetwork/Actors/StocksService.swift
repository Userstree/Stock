//
// Created by Dossymkhan Zhulamanov on 03.08.2022.
//

protocol StocksServiceable {
    func getAllStocksList() async throws -> [SingleStockViewModel]
}

actor StocksService: StocksServiceable {

    // MARK: - Properties, aka Vars & Lets
    var stocksViewModelList: [SingleStockViewModel] = []
    var stockPrices: [String: Double] = [:]
    var stockViewModels = [SingleStockViewModel]()

    // MARK: - Services
    let imageService = ImageService()
    let merketInfoSerice: MarketDataServiceable = MarketDataService()

    // MARK: - Methods

    func getAllStocksList() async throws -> [SingleStockViewModel] {
        let urlString = URLBuilder.getAllStocks.makeString()
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw "Invalid HttpResponseCode"
        }
        let dataResponse = try JSONDecoder().decode([StockDetails].self, from: data)
        let stocksDetailsList = dataResponse[..<32]
        let stockSymbolsList = stocksDetailsList.map {
            $0.title
        }
        let dataResponseDict = dataResponse.toDictionary {
            $0.title
        }

        let imageUrlStringsDict = try await imageService.makeStockImageUrlStringsList(for: stockSymbolsList)
        let nonEmptyImageUrlStringsList = imageUrlStringsDict.filter {
            !$0.value.isEmpty
        }
        var chartDescriptors = [Descriptor]()
        for item in nonEmptyImageUrlStringsList {
            chartDescriptors.append(
                    Descriptor(
                            stockSymbol: item.key,
                            type: .marketData)
            )
            let price = try await fetchStockPrice(for: item.key)
            stockPrices[item.key] = price
        }

        let taskResultsDict = try await fetchGroupedStocksInfo(descriptors: chartDescriptors)
        let dict = taskResultsDict.filter {
            $1.candleSticks.count > 10
        }
        for item in dict {
            stockViewModels.append(
                    SingleStockViewModel(
                            title: item.key,
                            subTitle: dataResponseDict[item.key]!.subTitle,
                            logoImage: imageUrlStringsDict[item.key]!,
                            currentPrice: stockPrices[item.key]!,
                            candleSticks: item.value.candleSticks,
                            isLiked: false
                    )
            )
        }
        return stockViewModels
    }

    fileprivate func fetchGroupedStocksInfo(descriptors: [Descriptor]) async throws -> [String: MarketInfoResponse] {
        try await withThrowingTaskGroup(of: (String, MarketInfoResponse).self, returning: [String: MarketInfoResponse].self) { group in
            for descriptor in descriptors {
                group.addTask { [self] in
                    switch descriptor.type {
                    case .marketData:
                        let (symbol, market) = try await merketInfoSerice.fetchMarketInfo(descriptor.stockSymbol, numberOfDays: 3)
                        return (symbol, market)
                    }
                }
            }
            return try await group.reduce(into: [:]) {
                $0[$1.0] = $1.1
            }
        }
    }


    func fetchStockPrice(for symbol: String) async throws -> Double {
        if symbol.isEmpty {
            return -1
        }
        let urlString = URLBuilder.fetchQuote(symbol).makeString()
        let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
        let dataResponse = try JSONDecoder().decode(QuoteResponse.self, from: data)
        return dataResponse.currentPrice
    }

}


enum MediaType {
    case marketData
}

struct Descriptor {
    let stockSymbol: String
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
