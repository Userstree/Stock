//
// Created by Dossymkhan Zhulamanov on 31.07.2022.
//

protocol RemoteAPIRequestType {
    func getAllStocksList() async throws -> [SingleStockViewModel]
    func fetchStockImage(for symbol: String) async throws -> String
}

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
        let stocksDetailsList = dataResponse[..<25]

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
            for (index, item) in stocksDetailsList.enumerated() {
                stockViewModels.append(SingleStockViewModel(title: item.title, subTitle: item.subTitle, logoUrlString: imageStrings[index]))
            }
            stockViewModels.forEach {
                print($0.title)
            }
            return stockViewModels
        }
    }

    func fetchStockImage(for symbol: String) async throws -> String {
        if symbol.isEmpty { return "https://stock.adobe.com/search/images?k=no%20image%20available" }
        let urlString = URLBuilder.fetchImage(symbol).makeString()
        print(urlString)
        let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
        guard data.count > 2 else { return "https://stock.adobe.com/search/images?k=no%20image%20available" }
        let dataResponse = try JSONDecoder().decode(TwelveDataImage.self, from: data)
        if dataResponse.logo.isEmpty {
            return "https://stock.adobe.com/search/images?k=no%20image%20available"
        }
        print(dataResponse.logo)
        return dataResponse.logo
    }
}


struct SingleStockViewModel {
    var title: String
    var subTitle: String
    var logoUrlString: String
}

struct TwelveDataImage: Decodable {
    var logo: String
}
