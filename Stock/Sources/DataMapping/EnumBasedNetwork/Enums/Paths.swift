//
// Created by Dossymkhan Zhulamanov on 31.07.2022.
//


enum TwelveDataPaths: String {
    case logo = "/logo?symbol="
    case symbolSearch = "/symbol_search?symbol="
}

enum FinHubPaths: String {
    case logo = "/stock/profile2?symbol="
    case allStocks = "/stock/symbol?exchange=US"
    case quote = "/quote?symbol="
    case marketData = "/stock/candle"
}