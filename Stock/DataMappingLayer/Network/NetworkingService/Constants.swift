//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//
import RxSwift
import RxCocoa

struct Constants {

    // MARK: - The API base URLs

    static let apiBaseURLString = "https://api.twelvedata.com"
    static let webSocketURLString = "wss://ws.twelvedata.com"

    // MARK: - The parameters (Queries)

    struct Parameters {
//        static let
    }

    // MARK: - Header Fields

    enum HttpHeaderField {
        case contentType = "Content-Type"
        case authentication = "Authorization"
    }

    // MARK: - The content type (JSON)

    enum ContentType: String {
        case json = "application/json"
    }

}