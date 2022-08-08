//
// Created by Dossymkhan Zhulamanov on 31.07.2022.
//

protocol RemoteAPIRequestType {
    func getAllStocksList() async throws -> [SingleStockViewModel]
    func getCompanySummary(for symbol: String) async throws -> CompanySummary
//    func fetchStockImageUrlString(for symbol: String) async throws -> String
}

@MainActor
struct RemoteAPIRequest: RemoteAPIRequestType {

    let stocksService = StocksService()
    let summarySerice = CompanyProfileService()


    // MARK: - RemoteAPIRequestType
    func getAllStocksList() async throws -> [SingleStockViewModel] {
        return try await stocksService.getAllStocksList()
    }

    func fetchStockPrice(for symbol: String) async throws -> Int {
        if symbol.isEmpty {
            return -1
        }
        let urlString = URLBuilder.fetchQuote(symbol).makeString()
        let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
        let dataResponse = try JSONDecoder().decode(QuoteResponse.self, from: data)
        return Int(dataResponse.currentPrice)
    }

    func getCompanySummary(for symbol: String) async throws -> CompanySummary {
        try await summarySerice.makeProfileRequest(for: symbol, returnType: CompanySummary.self)
    }

}
