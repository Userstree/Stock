//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


actor SearchCompanySerice {

    var response: [SearchResult] = []

    nonisolated func lookingFor(query: String) async throws -> [SearchResult] {
        var urlString = URLBuilder.searchForSymbol(query).makeString()
        print(urlString)
        let dataResponse = try await makeRequest(using: URL(string: urlString)!, responseModel: SearchResponse.self)
        guard let dataResponse = dataResponse else { return [] }
        return dataResponse.data
    }

    private func makeRequest<T: Decodable>(using url: URL, responseModel: T.Type) async throws -> T? {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard data.count > 2 else {
            return nil
        }
        let dataResponse = try JSONDecoder().decode(T.self, from: data)
        return dataResponse
    }
}