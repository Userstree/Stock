//
// Created by Dossymkhan Zhulamanov on 27.07.2022.
//


class NetworkRouter<Endpoint: NetworkEndPointProtocol>: NetworkRouterProtocol {

    // MARK: - NetworkRouterProtocol
    func request(route: EndPoint, queryParameters: QueryParams?) -> URLRequest {
        var urlComponents = route.urlComponents

        // MARK: - Adding query parameters
        if let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map {
                URLQueryItem(name: $0, value: $1)
            }
        }

        guard let url = urlComponents.url else {
            fatalError("Could make the URL")
        }

        return URLRequest(url: url)
    }

}