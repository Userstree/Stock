//
// Created by Dossymkhan Zhulamanov on 02.08.2022.
//


struct MarketInfoResponse: Decodable {
    let high, close, low, open: [Double]?
    let timeIntervals: [TimeInterval]?

    enum CodingKeys: String, CodingKey {
        case high = "h"
        case close = "c"
        case low = "l"
        case open = "o"
        case timeIntervals = "t"
    }

    var candleSticks: [CandleStick] {
        var result = [CandleStick]()
        let today = Date().addingTimeInterval(-(Constants.day))
        let prior = today.addingTimeInterval(-(Constants.day * 3))
        for index in 0..<(open?.count ?? 3) {
            result.append(.init(high: high?[index] ?? 0,
                                low: low?[index] ?? 0,
                                open: open?[index] ?? 0,
                                close: close?[index] ?? 0,
                                date: Date(timeIntervalSince1970: timeIntervals?[index] ?? 0),
                                timeInterval: timeIntervals?[index] ?? 0 - prior.timeIntervalSince1970
            ))
        }
        let sortedData = result.sorted(by: { $0.date > $1.date })
        return sortedData
    }
}

struct CandleStick {
    let high: Double
    let low: Double
    let open : Double
    let close: Double
    let date: Date
    let timeInterval: TimeInterval
}

fileprivate struct Constants {
    static let apikey = "c3r69giad3i98m4iihgg"
    static let sandboxUrlBaseKey = "sandbox_c3r69giad3i98m4iihh0"
    static let baseUrlkey = "https://finnhub.io/api/v1/"
    static let day: TimeInterval = 3600 * 24
}
