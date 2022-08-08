//
// Created by Dossymkhan Zhulamanov on 02.08.2022.
//



struct QuoteResponse: Decodable {
    let currentPrice: Double

    enum CodingKeys: String, CodingKey {
        case currentPrice = "c"
    }
}
