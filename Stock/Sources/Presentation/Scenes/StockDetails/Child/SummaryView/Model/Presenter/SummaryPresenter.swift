//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


final class SummaryPresenter: SummaryPresenterType, SummaryInteractorOutputType {
    // MARK: - SummaryPresenterType Protocol Properties
    weak var view: SummaryViewType?
    var interactorInput: SummaryInteractorInputType!
    var router: SummaryRouterType!
    var symbol: String?

    // MARK: - SummaryPresenterType Protocol Methods
    func onViewDidLoad() {
        guard let symbol = symbol else { return }
        interactorInput.fetchRemoteSummary(for: symbol)
    }

    // MARK: - SummaryInteractorOutputType Protocol Methods
    func didPrepareSummaryEntity(_ value: SummaryEntityType) {
        view?.didPrepareEntity(value)
    }

}