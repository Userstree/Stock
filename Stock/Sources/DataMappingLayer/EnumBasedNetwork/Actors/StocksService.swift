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
        let stocksDetailsList = dataResponse[..<25]
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
        for item in taskResultsDict {
            switch item.value {
            case .market(let chartModel):
//                print(chartModel.filteredClose.
                stockViewModels.append(
                        SingleStockViewModel(
                                title: item.key,
                                subTitle: dataResponseDict[item.key]!.subTitle,
                                logoImage: imageUrlStringsDict[item.key]!,
                                currentPrice: stockPrices[item.key]!
                        )
                )
            }
        }
        return stockViewModels
    }

    fileprivate func fetchGroupedStocksInfo(descriptors: [Descriptor]) async throws -> [String: TaskResult] {
        try await withThrowingTaskGroup(of: (String, TaskResult).self, returning: [String: TaskResult].self) { group in
            for descriptor in descriptors {
                group.addTask { [self] in
                    switch descriptor.type {
                    case .marketData:
                        let (symbol, market) = try await merketInfoSerice.fetchMarketInfo(descriptor.stockSymbol,numberOfDays: 3)
                        return (symbol, TaskResult.market(market))
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
