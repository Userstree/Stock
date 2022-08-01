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
        var stockLogoImages = [UIImage]()
        // Finhub
        let urlString = URLBuilder.getAllStocks.makeString()
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 { throw(RemoteAPIError.invalidHttpResponseCode) }
        let dataResponse = try JSONDecoder().decode([StockDetails].self, from: data)
        let stocksDetailsList = dataResponse[..<10]
        return try await withThrowingTaskGroup(of: SingleStockViewModel.self) { group in
            for (stockData) in stocksDetailsList {
                group.addTask {
                    try await fetchStockImage(for: stockData.title)
//                    SingleStockViewModel(title: stockData.title,
//                                            subTitle: stockData.subTitle,
//                                            logo: try await fetchStockImage(for: stockData.title)
//                    )
                }
            }
            for try await image in group {
                print(image)
                stockLogoImages.append(image)
            }
//            for try await stock in group {
//                if Task.isCancelled { print("cancelled task"); break }
//                stockViewModels.append(stock)
//            }

            for (index, stock) in stocksDetailsList.enumerated() {
                print("logo images are ", stockLogoImages[index])
                stockViewModels.append(SingleStockViewModel(title: stock.title, subTitle: stock.subTitle, logo: stockLogoImages[index]))
            }
            stockViewModels.forEach{ print($0.title, " and the image is ", $0.logo)}
            return stockViewModels
        }
    }

    func fetchStockImage(for symbol: String) async throws -> UIImage {
        // TwelveData
        let urlString = URLBuilder.fetchImage(symbol).makeString()
        print(urlString)
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 { throw(RemoteAPIError.invalidHttpResponseCode) }
        let dataResponse = try JSONDecoder().decode(TwelveDataImage.self, from: data)
        print(dataResponse.logo)
        let noImageURL = URL(string: "https://www.google.com/search?q=noimage&sxsrf=ALiCzsY6V0jTPUEuuyFA-F7dyBCZRU6hKA:1659336033070&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjgl8G2hKX5AhUt_CoKHUjbAnwQ_AUoAXoECAIQAw&biw=1440&bih=731&dpr=2#imgrc=Mh4RAUlXV108FM")
        let (imageData, _) = try await URLSession.shared.data(from: URL(string: dataResponse.logo) ?? noImageURL!)
        return UIImage(data: imageData)!
    }
}


struct SingleStockViewModel {
    var title: String
    var subTitle: String
    var logo: UIImage
}

struct TwelveDataImage: Decodable {
    var logo: String
}
