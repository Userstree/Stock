//
// Created by Dossymkhan Zhulamanov on 27.07.2022.
//


protocol NetworkEndPointProtocol{
    var path: String { get }
    var baseString: String { get }
}

extension NetworkEndPointProtocol {
    var urlComponents: URLComponents {
        var components = URLComponents(string: baseString)!
        components.path = path
        return components
    }
}