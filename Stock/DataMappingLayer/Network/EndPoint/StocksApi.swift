//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//

public enum StocksApi{

}

enum NetworkEndPointType {
    case api
    case webSocket
}

enum StocksApi: EndPointType {

    var apiEndPointBaseURL: String {
        switch NetworkManager.endpointType {
        case .api:
            return Constants.apiBaseURLString
        case .webSocket:
            return Constants.webSocketURLString
        }
    }

    var baseURL: URL {
        fatalError("path has not been implemented")
    }
    var path: String {
        fatalError("path has not been implemented")
    }
    var httpMethod: HTTPMethod {
        fatalError("httpMethod has not been implemented")
    }
    var task: HTTPTask {
        fatalError("task has not been implemented")
    }
    var headers: HTTPHeaders? {
        fatalError("headers has not been implemented")
    }
}


