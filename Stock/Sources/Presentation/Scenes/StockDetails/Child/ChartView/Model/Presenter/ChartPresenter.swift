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

    func chartTimeFrameRequest(for value: (String)?){
        if var timeInterval = value {
                getChartData(for: timeInterval)
        }
    }

    // MARK: - ChartInteractorOutputType Protocol Impl
    func didPrepareSummaryEntity(_ value: CompanySummary) {
        view?.didPrepareCompanySummary(value)
    }


    // MARK: - Private Methods
    private func fetchRequest(symbol: String) {
        interactorInput.loadRemoteSummary(for: symbol)
    }

    private func getChartData(for timeInterval: String) {
        print("get chart data for timeInterval of ", timeInterval)
    }
}