//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


final class StockDetailsPresenter: StockDetailsPresenterType, StockDetailsInteractorOutputType {
    // MARK: - StockDetailsPresenterType Protocol Properties
    weak var view: StockDetailsViewType?
    var interactorInput: StockDetailsInteractorInputType!
    var router: StockDetailsRouterType!


    // MARK: - StockDetailsPresenterType Protocol Methods
    func onViewDidLoad() {

    }

    // MARK: - StockDetailsInteractorOutputType Protocol

}