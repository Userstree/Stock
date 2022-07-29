//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//

struct StocksListDetails<A: StockDetailsModellable>: Decodable {
    var data: [A]
}

struct StockDetails: StockDetailsModellable {
    var title: String
    var subTitle: String

    enum CodingKeys: String, CodingKey {
        case title = "symbol"
        case subTitle = "description"
    }

}
