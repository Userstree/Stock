//
// Created by Dossymkhan Zhulamanov on 27.07.2022.
//

import Foundation

enum StocksEndPoint {
    case exchanges
    case stocksList
    case logo
    case priceWebSocket
}

extension StocksEndPoint: NetworkEndPointProtocol {

    // MARK: - EndPointProtocol
    var path: String {
        switch self {
        case .exchanges: return "/exchanges"
        case .logo: return "/logo"
        case .stocksList: return "/stocks"
        case .priceWebSocket: return "/quotes/price"
        }
    }

    var baseString: String {
        switch self {
        case .exchanges, .logo, .stocksList: return Type.api.baseURLString
        case .priceWebSocket: return Type.webSocket.baseURLString
        }
    }

}