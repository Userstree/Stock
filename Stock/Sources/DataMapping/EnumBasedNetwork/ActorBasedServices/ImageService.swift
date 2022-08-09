//
// Created by Dossymkhan Zhulamanov on 03.08.2022.
//


actor ImageService {

    // MARK: - Properties
    let urlSession = URLSession.shared
//    var pending: Set<String> = []
//    var inProgress: Set<String> = []
//    var finished: [String: UIImage] = [:]

    // MARK: - Methods
    func processImagesListFrom(_ urlStrings: [String]) async throws -> [String: UIImage] {
        try await withThrowingTaskGroup(of: (String, UIImage).self, returning: [String: UIImage].self) { group in
            for imageString in urlStrings {
                group.addTask { [self] in
                    try await makeStockImageTuple(imageString)
                }
            }
            return try await group.reduce(into: [:]) {
                $0[$1.0] = $1.1
            }
        }
    }


    func makeStockImageUrlStringsList(for symbols: [String]) async throws -> [String: String] {
        try await withThrowingTaskGroup(of: (String, String).self, returning: [String: String].self) { group in
            for symbol in symbols {
                group.addTask { [self] in
                    try await fetchStockImageUrlString(for: symbol)
                }
            }
            return try await group.reduce(into: [:]) {
                $0[$1.0] = $1.1
            }
        }
    }

    func makeStockImageTuple(_ symbol: String) async throws -> (String, UIImage) {
        let symbolUrl = URL(string: symbol)!
        let (data, _) = try await urlSession.data(from: symbolUrl)
        guard let image = UIImage(data: data) else {
            return (symbolUrl.absoluteString, UIImage(named: "no-Image")!)
        }
        return (symbolUrl.absoluteString, image)
    }

    func fetchStockImageUrlString(for symbol: String) async throws -> (String, String) {
        if symbol.isEmpty {
            return (symbol, "")
        }
        let urlString = URLBuilder.fetchProfile(symbol).makeString()
        let (data, _) = try await urlSession.data(from: URL(string: urlString)!)
        guard data.count > 2 else {
            return (symbol, "")
        }
        let dataResponse = try JSONDecoder().decode(LogoURLString.self, from: data)
        if dataResponse.logo.isEmpty {
            return (symbol, "")
        }
        return (symbol, dataResponse.logo)
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