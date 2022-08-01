//
// Created by Dossymkhan Zhulamanov on 31.07.2022.
//

protocol RemoteAPIRequestType {
    func getAllStocksList() async throws -> [SingleStockViewModel]
    func fetchStockImage(for symbol: String) async throws -> UIImage
}

struct RemoteAPIRequest: RemoteAPIRequestType {

    // MARK: - RemoteAPIRequestType
    func getAllStocksList() async throws -> [SingleStockViewModel] {
        var stockViewModels = [SingleStockViewModel]()
        // Finhub
        let urlString = URLBuilder.getAllStocks.makeString()
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 { throw(RemoteAPIError.invalidHttpResponseCode) }
        let dataResponse = try JSONDecoder().decode([StockDetails].self, from: data)
        let stocksDetailsList = dataResponse[..<30]
        try await withThrowingTaskGroup(of: SingleStockViewModel.self) { group in
            for (stockData) in stocksDetailsList {
                group.addTask {
                    SingleStockViewModel(title: stockData.title,
                                            subTitle: stockData.subTitle,
                                            logo: try await fetchStockImage(for: stockData.title)
                    )
                }
            }
            for try await stock in group {
                if Task.isCancelled { print("cancelled task"); break }
                stockViewModels.append(stock)
            }
        }
        return stockViewModels
    }

    func fetchStockImage(for symbol: String) async throws -> UIImage {
        // TwelveData
        let urlString = URLBuilder.fetchImage(symbol).makeString()
        print(urlString)
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 { throw(RemoteAPIError.invalidHttpResponseCode) }
        let dataResponse = try JSONDecoder().decode(TwelveDataImage.self, from: data)
        print(dataResponse.url)
        let (imageData, _) = try await URLSession.shared.data(from: URL(string: dataResponse.url)!)
        return UIImage(data: imageData)!
    }
}


struct SingleStockViewModel {
    var title: String
    var subTitle: String
    var logo: UIImage
}

struct TwelveDataImage: Decodable {
    var url: String
}
