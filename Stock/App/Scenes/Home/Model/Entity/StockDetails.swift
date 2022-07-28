//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//

struct StocksListDetails: Decodable {
    var data: [StockDetails]
}

struct StockDetails: Decodable {
    var title: String
    var subTitle: String
//    var image: Data
//    var price: Int
//    var previosPrice: Int
    enum CodingKeys: String, CodingKey {
        case title = "symbol"
        case subTitle = "name"
    }
}
