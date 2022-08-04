//
// Created by Dossymkhan Zhulamanov on 03.08.2022.
//

protocol StocksServiceable {
    func getAllStocksList() async throws -> [SingleStockViewModel]
}

actor StocksService: StocksServiceable {

    // MARK: - Properties, aka Vars & Lets
    var stocksViewModelList: [SingleStockViewModel] = []

    // MARK: - Services
    let imageService = ImageService()
    let merketInfoSerice: MarketDataServiceable = MarketDataService()

    // MARK: - Methods

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
        let dataResponseDict = dataResponse.toDictionary {
            $0.title
        }
        print(2)

        var stockPrices: [String: Double] = [:]
        let imageUrlStringsDict = try await imageService.makeStockImageUrlStringsList(for: stockSymbolsList)
        let nonEmptyImageUrlStringsList = imageUrlStringsDict.filter {
            !$0.value.isEmpty
        }
        var imageDescriptors = [Descriptor]()
//        var chartDescriptors = [Descriptor]()
        for item in nonEmptyImageUrlStringsList {
            imageDescriptors.append(
                    Descriptor(
                            stockSymbol: item.key,
                            stockImageUrlString: nonEmptyImageUrlStringsList[item.key]!,
                            type: .image)
            )
//            chartDescriptors.append(
//                    Descriptor(stockSymbol: item.key,
//                            stockImageUrlString: "",
//                            type: .marketData)
//            )
            let price = try await fetchStockPrice(for: item.key)
            stockPrices[item.key] = price
        }

//        print(chartDescriptors)
        let taskResultsDict = try await fetchGroupedStocksInfo(descriptors: imageDescriptors)
        print(taskResultsDict)
//        let marketDataTaskResultDict = try await fetchGroupedStocksInfo(descriptors: chartDescriptors)
        for item in taskResultsDict {
            switch item.value {
            case .image(let image):
                stockViewModels.append(
                        SingleStockViewModel(
                                title: item.key,
                                subTitle: dataResponseDict[item.key]!.subTitle,
                                logoImage: image,
                                currentPrice: stockPrices[item.key]!
                        )
                )
                print(item.key)
//            case .marketData(let data):
//                print("data is ", data)
            default:
                break
            }
        }
        return stockViewModels
    }

    fileprivate func fetchGroupedStocksInfo(descriptors: [Descriptor]) async throws -> [String: TaskResult] {
        try await withThrowingTaskGroup(of: (String, TaskResult).self, returning: [String: TaskResult].self) { group in
            for descriptor in descriptors {
//                print(Task.isCancelled)
                group.addTask { [self] in
                    switch descriptor.type {
                    case .image:
                        let (_, image) = try await self.imageService.makeStockImageTuple(descriptor.stockImageUrlString)
                        async let market = try merketInfoSerice.fetchMarketInfo(descriptor.stockSymbol, numberOfDays: 3)
                        let x = try await market
                        return (descriptor.stockSymbol, TaskResult.image(image))
                    case .marketData:
                        let (symbol, marketResponse) = try await merketInfoSerice.fetchMarketInfo(descriptor.stockSymbol, numberOfDays: 3)
//                        print("response is ", marketResponse.close)
                        return (symbol, TaskResult.marketData(marketResponse))
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
