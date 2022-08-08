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
    /// ChildViewControllers inits
    private let chartViewController = ChartViewController()
    private let newsViewController = NewsViewController()
    private let summaryViewController = SummaryViewController()
    private lazy var viewControllers = [chartViewController, newsViewController, summaryViewController]
    private let controllersTitles = ["Chart",
                                    "Summary",
                                    "News"
    ]

    // MARK: - StockDetailsPresenterType Protocol Methods
    func onViewDidLoad() {
        view?.didPrepareViewControllers(viewControllers, titles: controllersTitles)
    }

    // MARK: - StockDetailsInteractorOutputType Protocol


    // MARK: - StockDetailsModuleInput Protocol
    func configure(with stockViewModel: SingleStockViewModel) {
        self.stockViewModel = stockViewModel
    }

}