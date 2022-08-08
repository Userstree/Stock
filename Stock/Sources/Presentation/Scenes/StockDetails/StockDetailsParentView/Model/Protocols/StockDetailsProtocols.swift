//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


// MARK: View Output (Presenter -> View)
protocol StockDetailsViewType: AnyObject {
    // MARK: - Properties
    var viewOutput: StockDetailsPresenterType! { get set }

    // MARK: - Methods
    func didPrepareViewControllers(_ value: [UIViewController], titles: [String])
}


// MARK: View Input (View -> Presenter)
protocol StockDetailsPresenterType: AnyObject {
    // MARK: - Properties
    var view: StockDetailsViewType? { get set }
    var interactorInput: StockDetailsInteractorInputType! { get set }
    var router: StockDetailsRouterType! { get set }

    // MARK: - Methods
    func onViewDidLoad()

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol StockDetailsInteractorInputType: AnyObject {
    // MARK: - Properties
    var interactorOutput: StockDetailsInteractorOutputType? { get set }
    var remoteDataRepository: RemoteDataRepositoryType! { get set }
    // MARK: - Methods


}


// MARK: Interactor Output (Interactor -> Presenter)
protocol StockDetailsInteractorOutputType: AnyObject {
    // MARK: - Properties


    // MARK: - Methods

}


// MARK: Router Input (Presenter -> Router)
protocol StockDetailsRouterType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods

}


// MARK: Router Input (Presenter -> Router)
typealias StockDetailsModuleConfiguration = (StockDetailsModuleInput) -> Void

protocol StockDetailsModuleInput: AnyObject {
    func configure(with stockViewModel: SingleStockViewModel)
}
