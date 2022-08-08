//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


final class StockDetailsPresenter: StockDetailsPresenterType, StockDetailsInteractorOutputType, StockDetailsModuleInput {
    // MARK: - StockDetailsPresenterType Protocol Properties
    weak var view: StockDetailsViewType?
    var interactorInput: StockDetailsInteractorInputType!
    var router: StockDetailsRouterType!

    // MARK: - Properties
    private var stockViewModel: SingleStockViewModel!

    // MARK: - StockDetailsPresenterType Protocol Methods
    func onViewDidLoad() {

    }

    // MARK: - StockDetailsInteractorOutputType Protocol


    // MARK: - StockDetailsModuleInput Protocol
    func configure(with stockViewModel: SingleStockViewModel) {
        self.stockViewModel = stockViewModel
    }

}