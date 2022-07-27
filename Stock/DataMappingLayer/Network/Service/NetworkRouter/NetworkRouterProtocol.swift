//
// Created by Dossymkhan Zhulamanov on 27.07.2022.
//


protocol NetworkRouterProtocol {
    associatedtype EndPoint: NetworkEndPointProtocol
    func request(route: EndPoint, queryParameters: QueryParameters?) -> URLRequest
}
