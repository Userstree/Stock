//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


struct CompanySummary: Codable {
    var country: String
    var currency: String
    var exchange: String
    var marketCapitalization: Double
    var shareOutstanding: Double
    var name: String
    var weburl: String
    var logo: String
    var finnhubIndustry: String
}