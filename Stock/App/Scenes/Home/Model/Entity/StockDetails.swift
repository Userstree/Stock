//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//

struct StocksListDetails: Decodable {
    var data: [StockDetails]
}

struct StockDetails: Decodable {
    var title: String
    var subTitle: String

    enum CodingKeys: String, CodingKey {
        case title = "symbol"
        case subTitle = "description"
    }
}
