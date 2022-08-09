//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


struct SearchResponse: Codable {
//    let count: Int?
    let data: [SearchResult]
}

struct SearchResult: Codable {
    let symbol: String
    let exchange: String
}