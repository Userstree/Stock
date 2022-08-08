//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


struct CompanySummary: Decodable {
    var country: String
    var currency: String
    var exchange: String
    var ipo: String
    var marketCapitalization: Int
    var shareOutstanding: Int
    var name: String
    var weburl: String
    var logo: String
    var finnhubIndustry: [String]
}