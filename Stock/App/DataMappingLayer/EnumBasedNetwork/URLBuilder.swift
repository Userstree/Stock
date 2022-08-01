//
// Created by Dossymkhan Zhulamanov on 30.07.2022.
//


enum URLBuilder {
    case fetchImage(_ symbol: String)
    case getAllStocks
    case searchForSymbol(_ symbol: String)
}

extension URLBuilder {

    fileprivate var basePath: String {
        switch self {
        case .fetchImage:               return "https://api.twelvedata.com"
        case .getAllStocks:             return "https://finnhub.io/api/v1"
        case .searchForSymbol:          return "https://api.twelvedata.com"
        }
    }

    fileprivate var path: String {
        switch self {
        case .fetchImage:               return TwelveDataPaths.logo.rawValue
        case .getAllStocks:             return FinHubPaths.allStocks.rawValue
        case .searchForSymbol:          return TwelveDataPaths.symbolSearch.rawValue
        }
    }

    fileprivate var endPoint: String {
        switch self {
        case .fetchImage(let imageSymbol):      return imageSymbol
        case .searchForSymbol(let symbol):      return symbol
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
            urlString.append(basePath + path + endPoint + APIKEYS.twelveData.rawValue)
        case .searchForSymbol:
            urlString.append(basePath + path + endPoint)
        }
        return urlString
    }

}

