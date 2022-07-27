//
// Created by Dossymkhan Zhulamanov on 27.07.2022.
//


typealias QueryParameters = [String : String]

enum QueryParametersOptions {
    case symbol(String)
    case apiKey
}

extension QueryParametersOptions {
    var queries: QueryParameters {
        switch self {
        case .apiKey: return ["apikey" : "349fabdc272c4af5a5193f8a6f76eec6"]
        case .symbol(let value): return ["symbol" : value]
        }
    }
}