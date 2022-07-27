//
// Created by Dossymkhan Zhulamanov on 27.07.2022.
//


enum Type {
    case api
    case webSocket
}

extension Type {
    var baseURLString: String {
        switch self {
        case .api:
            return "https://api.twelvedata.com"
        case .webSocket:
            return "wss://ws.twelvedata.com"
        }
    }
}