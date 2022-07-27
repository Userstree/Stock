//
// Created by Dossymkhan Zhulamanov on 27.07.2022.
//

import RxSwift
import RxCocoa

public class NetworkManager {
    let router = NetworkRouter<StocksEndPoint>()

    func sendApiRequest<T: Codable>(to endpoint: StocksEndPoint, with queryParams: QueryParameters? = nil) -> Observable<T> {
        switch endpoint {
        case .exchanges: return router.request(route: StocksEndPoint.exchanges)
        case .logo: return router.request(route: StocksEndPoint.logo, queryParameters: queryParams)
        case .stocksList: return router.request(route: StocksEndPoint.stocksList, queryParameters: queryParams)
        case .priceWebSocket: return router.request(route: StocksEndPoint.priceWebSocket, queryParameters: queryParams)
        }
    }
}
