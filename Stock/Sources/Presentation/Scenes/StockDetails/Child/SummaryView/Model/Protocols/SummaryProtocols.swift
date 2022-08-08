//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


// MARK: View Output (Presenter -> View)
protocol SummaryViewType: AnyObject {
    // MARK: - Properties
    var viewOutput: SummaryPresenterType! { get set }

    // MARK: - Methods
    func didPrepareEntity(_ value: SummaryEntityType)
}


// MARK: View Input (View -> Presenter)
protocol SummaryPresenterType: AnyObject {
    // MARK: - Properties
    var view: SummaryViewType? { get set }
    var interactorInput: SummaryInteractorInputType! { get set }
    var router: SummaryRouterType! { get set }
    var symbol: String? { get set }

    // MARK: - Methods
    func onViewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol SummaryInteractorInputType: AnyObject {
    // MARK: - Properties
    var interactorOutput: SummaryInteractorOutputType? { get set }
    var summaryEntity: SummaryEntityType? { get set }
    var remoteDataRepository: RemoteDataRepositoryType? { get set }

    // MARK: - Methods
    func fetchRemoteSummary(for symbol: String)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol SummaryInteractorOutputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods
    func didPrepareSummaryEntity(_ value: SummaryEntityType)
}


// MARK: Router Input (Presenter -> Router)
protocol SummaryRouterType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods
}