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
        view?.didPassStockViewModel(stockInitialViewModel!)
    }

    // MARK: - ChartInteractorOutputType Protocol Impl


    // MARK: - Properties


    // MARK: - Methods


}