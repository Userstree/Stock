//
// Created by Dossymkhan Zhulamanov on 27.07.2022.
//

import RxSwift
import RxCocoa

struct NetworkManager {

    // MARK: - Vars & Lets
    private let session = URLSession.shared
    private let router = NetworkRouter<StocksEndPoint>()

    // MARK: - Private methods
    private func buildApiRequest(to endpoint: StocksEndPoint) -> URLRequest {
        switch endpoint {
        case .exchanges: return router.request(route: StocksEndPoint.exchanges)
        case .logo: return router.request(route: StocksEndPoint.logo)
        case .stocksList: return router.request(route: StocksEndPoint.stocksList)
        case .priceWebSocket: return router.request(route: StocksEndPoint.priceWebSocket)
        }
    }

    private func buildApiRequest(to endpoint: StocksEndPoint, with queryParams: QueryParams?) -> URLRequest {
        switch endpoint {
        case .exchanges: return router.request(route: StocksEndPoint.exchanges)
        case .logo: return router.request(route: StocksEndPoint.logo, queryParameters: queryParams)
        case .stocksList: return router.request(route: StocksEndPoint.stocksList, queryParameters: queryParams)
        case .priceWebSocket: return router.request(route: StocksEndPoint.priceWebSocket, queryParameters: queryParams)
        }
    }

    private func makeObservedGetRequest<T: Codable>(request: inout URLRequest) -> Observable<T> {
        request.httpMethod = "GET"
        session.rx.data(request: request)
                .map {
                    try JSONDecoder().decode(T.self, from: $0)
                }
    }

    private func makeObservedPostRequest<T: Codable>(request: inout URLRequest) -> Observable<T> {
        request.httpMethod = "POST"
        session.rx.data(request: request)
                .map {
                    try JSONDecoder().decode(T.self, from: $0)
                }
    }

    // MARK: - Methods
    func sendExchangesRequest<T: Codable>() -> Observable<T> {
        var request = buildApiRequest(to: .exchanges)
        return makeObservedGetRequest(request: &request)
    }

    func sendLogoRequest<T: Codable>(queryParameters: QueryParametersOptions) -> Observable<T> {
        var request = buildApiRequest(to: .logo, with: queryParameters.queries)
        return makeObservedGetRequest(request: &request)
    }

    func sendStocksListRequest<T: Codable>(queryParameters: QueryParametersOptions) -> Observable<T> {
        var request = buildApiRequest(to: .stocksList, with: queryParameters.queries)
        return makeObservedGetRequest(request: &request)
    }

    func sendPriceWebSocketRequest<T: Codable>(queryParameters: QueryParametersOptions) -> Observable<T> {
        var request = buildApiRequest(to: .priceWebSocket, with: queryParameters.queries)
        return makeObservedGetRequest(request: &request)
    }

}
