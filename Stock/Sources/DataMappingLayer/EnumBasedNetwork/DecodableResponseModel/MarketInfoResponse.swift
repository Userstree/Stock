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
        for index in 0..<open!.count {
            result.append(.init(high: high[index],
                    low: low[index],
                    close: close[index],
                    open: open[index],
                    date: Date(timeIntervalSince1970: timeIntervals[index]),
                    timeInterval: timeIntervals[index] - prior.timeIntervalSince1970
            ))
        }
        return result
    }
}


struct CandleStick {
    let high: Double
    let low: Double
    let open : Double
    let close: Double
    let timeInterval: TimeInterval
}

fileprivate struct Constants {
    static let apikey = "c3r69giad3i98m4iihgg"
    static let sandboxUrlBaseKey = "sandbox_c3r69giad3i98m4iihh0"
    static let baseUrlkey = "https://finnhub.io/api/v1/"
    static let day: TimeInterval = 3600 * 24
}