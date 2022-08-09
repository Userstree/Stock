//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class ChartPresenter: ChartPresenterType, ChartInteractorOutputType {
    // MARK: - ChartPresenterType Protocol Properties
    weak var view: ChartViewType?
    var interactorInput: ChartInteractorInputType!
    var router: ChartRouterType!
    var stockInitialViewModel: SingleStockViewModel?


    // MARK: - ChartPresenterType Protocol Methods
    func onViewDidLoad() {
        guard let symbol = stockInitialViewModel?.title else {
            return
        }
        fetchRequest(symbol: symbol)
        view?.didPassStockViewModel(stockInitialViewModel!)
    }

    private func fetchRequest(symbol: String) {
        interactorInput.loadRemoteSummary(for: symbol)
        interactorInput.fetchRemoteSummary(for: symbol)
    }

    // MARK: - ChartInteractorOutputType Protocol Impl
    func didPrepareSummaryEntity(_ value: SummaryEntityType) {
        print(" in presenter ")
        view?.didPrepareCompanySummary(value)
    }


    // MARK: - Properties


    // MARK: - Methods
}