//
// Created by Dossymkhan Zhulamanov on 03.08.2022.
//

protocol StocksServiceable {
    func getAllStocksList() async throws -> [SingleStockViewModel]
}

actor StocksService: StocksServiceable {

    // MARK: - Properties
    var stocksViewModelList: [SingleStockViewModel] = []
    var stockPrices: [String: Double] = [:]
    var stockViewModels = [SingleStockViewModel]()
    var stockDetailsDictByTitle: [String : StockDetails] = [:]

    // MARK: - Services
    let merketInfoSerice: MarketDataServiceable = MarketDataService()

    // MARK: - Methods

    func getStockSymbolsList() async throws -> [String] {
        let urlString = URLBuilder.getAllStocks.makeString()
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw "Invalid HttpResponseCode"
        }
        let dataResponse = try JSONDecoder().decode([StockDetails].self, from: data)
        let stocksDetailsList = dataResponse[..<32]
        stockDetailsDictByTitle = dataResponse.toDictionary {
            $0.title
        }
        print(stocksDetailsList)
        return stocksDetailsList.map {
            $0.title
        }
    }

    func getAllStocksList() async throws -> [SingleStockViewModel] {
        let stockSymbolsList = try await getStockSymbolsList()

        var chartDescriptors = [Descriptor]()
        for item in stockSymbolsList {
            chartDescriptors.append(
                    Descriptor(
                            stockSymbol: item,
                            type: .marketData)
            )
            let price = try await fetchStockPrice(for: item)
            stockPrices[item] = price
        }

        let taskResultsDict = try await fetchGroupedStocksInfo(descriptors: chartDescriptors)
        print(taskResultsDict)
        let dict = taskResultsDict.filter {
            $1.candleSticks.count > 10
        }
        print("candle sticks ", dict)
        for item in dict {
            stockViewModels.append(
                    SingleStockViewModel(
                            title: item.key,
                            subTitle: stockDetailsDictByTitle[item.key]!.subTitle,
                            currentPrice: stockPrices[item.key]!,
                            priceChange: computeChangePrice(for: item.key, from: item.value.candleSticks),
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
                        return try await merketInfoSerice.fetchMarketInfo(descriptor.stockSymbol, numberOfDays: 3)
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

    private func computeChangePrice(for symbol: String, from data: [CandleStick]) -> Double {
        let latestDate = data[0].date
        guard let latestClose = data.first?.close,
              let priorClose = data.first(where: {
                          !Calendar.current.isDate($0.date, inSameDayAs: latestDate)
                      })?
                      .close
        else {
            return 0
        }
        let diff = 1 - (priorClose / latestClose)
        return diff
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
