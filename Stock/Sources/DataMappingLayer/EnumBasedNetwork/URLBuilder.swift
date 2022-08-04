//
// Created by Dossymkhan Zhulamanov on 30.07.2022.
//


enum URLBuilder {
    case fetchImage(_ symbol: String)
    case getAllStocks
    case searchForSymbol(_ symbol: String)
    case fetchQuote(_ symbol: String)
    case fetchMarketData(_ symbol: String,_ numberOfDays: TimeInterval)
}

extension URLBuilder {

    fileprivate var basePath: String {
        switch self {
        case .searchForSymbol:          return "https://api.twelvedata.com"
        default:
            return "https://finnhub.io/api/v1"
        }
    }

    fileprivate var path: String {
        switch self {
        case .fetchImage:               return FinHubPaths.logo.rawValue
        case .getAllStocks:             return FinHubPaths.allStocks.rawValue
        case .searchForSymbol:          return TwelveDataPaths.symbolSearch.rawValue
        case .fetchQuote:               return FinHubPaths.quote.rawValue
        case .fetchMarketData:          return FinHubPaths.marketData.rawValue
        }
    }

    fileprivate var endPoint: String {
        switch self {
        case .fetchImage(let imageSymbol):      return imageSymbol
        case .searchForSymbol(let symbol):      return symbol
        case .fetchQuote(let symbol):           return symbol
        case .fetchMarketData(let symbol, _):   return "?symbol=" + symbol
        default:
            return ""
        }
    }

    fileprivate var queryParams: String {
        switch self {
        case .fetchMarketData(_, let numberOfDays):
            let today = Date().addingTimeInterval(-(3600 * 24))
            let prior = Date().addingTimeInterval(-(3600 * 24 * numberOfDays))

            let params: [String : String] = [
                "resolution" : "1",
                "from" : "\(Int(prior.timeIntervalSince1970))",
                "to" : "\(Int(today.timeIntervalSince1970))"
            ]
            var queryItems = [URLQueryItem]()
            for (name, value) in params {
                queryItems.append(.init(name: name, value: value))
            }
            return "&" + queryItems.map{ "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        default:
            return ""
        }
    }

    func makeString() -> String {
        var urlString = ""
        switch self {
        case .getAllStocks:
            urlString.append(basePath + path + APIKEYS.finHub.rawValue)
        case .fetchImage:
            urlString.append(basePath + path + endPoint + APIKEYS.finHub.rawValue)
        case .searchForSymbol:
            urlString.append(basePath + path + endPoint)
        case .fetchQuote:
            urlString.append(basePath + path + endPoint + APIKEYS.finHub.rawValue)
        case .fetchMarketData:
            urlString.append(basePath + path + endPoint + queryParams + APIKEYS.finHub.rawValue)
        }
        return urlString
    }
}

