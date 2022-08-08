//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


// MARK: View Output (Presenter -> View)
protocol SummaryViewType: AnyObject {
    // MARK: - Properties
    var presenter: SummaryPresenterType! { get set }

    // MARK: - Methods
}


// MARK: View Input (View -> Presenter)
protocol SummaryPresenterType: AnyObject {
    // MARK: - Properties
    var view: SummaryViewType? { get set }
    var interactorInput: SummaryInteractorInputType! { get set }
    var router: SummaryRouterType! { get set }

    // MARK: - Methods
    func onViewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol SummaryInteractorInputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods

}


// MARK: Interactor Output (Interactor -> Presenter)
protocol SummaryInteractorOutputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods

}


// MARK: Router Input (Presenter -> Router)
protocol SummaryRouterType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods
}