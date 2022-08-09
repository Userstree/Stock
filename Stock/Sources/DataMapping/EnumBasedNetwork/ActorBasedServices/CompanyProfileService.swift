//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


actor CompanyProfileService {
    // MARK: - Properties
    let urlSession = URLSession.shared

    // MARK: - Methods
    func makeProfileRequest<T: Decodable>(for symbol: String, returnType: T.Type) async throws -> T {
        let urlString = URLBuilder.fetchProfile(symbol).makeString()
        let (data, response) = try await urlSession.data(from: URL(string: urlString)!)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw "Invalid HttpResponseCode"
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}