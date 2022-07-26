//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//



// MARK: View Output (Presenter -> View)
protocol ChartViewType: AnyObject {
    // MARK: - Properties
    var viewOutput: ChartPresenterType! { get set }

    // MARK: - Methods
    func didPassStockViewModel(_ value: SingleStockViewModel)
    func didPrepareCompanySummary(_ value: CompanySummary)
}


// MARK: View Input (View -> Presenter)
protocol ChartPresenterType: AnyObject {
    // MARK: - Properties
    var view: ChartViewType? { get set }
    var interactorInput: ChartInteractorInputType! { get set }
    var router: ChartRouterType! { get set }
    var stockInitialViewModel: SingleStockViewModel? { get set }

    // MARK: - Methods
    func onViewDidLoad()
    func chartTimeFrameRequest(for value: (String)?)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol ChartInteractorInputType: AnyObject {
    // MARK: - Properties
    var interactorOutput: ChartInteractorOutputType! { get set }
    var chartEntity: ChartEntityType? { get set }
    var summaryEntity: SummaryEntity? { get set }
    var remoteDataRepository: RemoteDataRepositoryType? { get set }

    // MARK: - Methods
    func fetchRemoteStockData(title: String, resolution: String)
    func loadRemoteSummary(for symbol: String)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol ChartInteractorOutputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods
    func didPrepareSummaryEntity(_ value: CompanySummary)
}


// MARK: Router Input (Presenter -> Router)
protocol ChartRouterType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods
}