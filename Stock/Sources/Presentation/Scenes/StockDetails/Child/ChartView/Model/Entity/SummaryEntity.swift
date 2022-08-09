//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//

protocol SummaryEntityType {
    var finnhubIndustry: CompanySummary { get set }
}

final class SummaryEntity: SummaryEntityType {
    var finnhubIndustry: CompanySummary
}