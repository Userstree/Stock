//
// Created by Dossymkhan Zhulamanov on 02.08.2022.
//


struct SingleStockViewModel: Sendable {
    var title: String
    var subTitle: String
    var logoImage: String
    var currentPrice: Double
    var candleSticks: [CandleStick]
    var isLiked: Bool
}

extension SingleStockViewModel: Equatable {
    public static func ==(lhs: SingleStockViewModel, rhs: SingleStockViewModel) -> Bool {
        (lhs.title, lhs.subTitle, lhs.currentPrice) == (rhs.title, rhs.subTitle, rhs.currentPrice)
    }
}