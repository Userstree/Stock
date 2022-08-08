//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//

protocol SummaryEntityType {
    // MARK: - Properties
    var companySummary: CompanySummary? { get set }

    // MARK: - Methods
}

final class SummaryEntity: SummaryEntityType {
    // MARK: - Properties
    var companySummary: CompanySummary?
    // MARK: - Methods
}