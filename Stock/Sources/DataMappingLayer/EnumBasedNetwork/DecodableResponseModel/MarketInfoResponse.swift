//
// Created by Dossymkhan Zhulamanov on 02.08.2022.
//


struct MarketInfoResponse: Decodable {
    let high, close, low, open: [Double]
    let timeIntervals: [TimeInterval]

    enum CodingKeys: String, CodingKey {
        case high = "h"
        case close = "c"
        case low = "l"
        case open = "o"
        case timeIntervals = "t"
    }
}
