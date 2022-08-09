//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


@MainActor
final class StockDetailsPresenter: StockDetailsPresenterType, StockDetailsInteractorOutputType {
    // MARK: - StockDetailsPresenterType Protocol Properties
    weak var view: StockDetailsViewType?
    var interactorInput: StockDetailsInteractorInputType!
    var router: StockDetailsRouterType!

    
    // MARK: - StockDetailsPresenterType Protocol Methods
    func onViewDidLoad() {
        view?.didPrepareViewControllers(viewControllers, titles: controllersTitles)
        view?.didPassStockInfo(singleStockViewModel: stockViewModel)
    }


    // MARK: - StockDetailsInteractorOutputType Protocol


    // MARK: - Methods
    func configure(with stockViewModel: SingleStockViewModel) {
        self.stockViewModel = stockViewModel
    }


    // MARK: - Properties
    var stockViewModel: SingleStockViewModel!
    /// ChildViewControllers inits
    private lazy var chartViewController = ChartModelChildAssemble.assemble(with: stockViewModel)
    private lazy var newsViewController = NewsModelChildAssemble.assemble(with: stockViewModel)
//    private lazy var summaryViewController = SummaryModelChildAssemble.assemble(with: stockViewModel)

    private lazy var viewControllers = [
        chartViewController,
        newsViewController,
//        summaryViewController,
    ]
    private let controllersTitles = ["Chart",
//                                     "Summary",
                                     "News"
    ]

}