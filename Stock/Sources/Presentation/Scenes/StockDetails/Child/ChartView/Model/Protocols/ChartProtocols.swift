//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//



// MARK: View Output (Presenter -> View)
protocol ChartViewType: AnyObject {
    // MARK: - Properties
    var presenter: ChartPresenterType! { get set }

    // MARK: - Methods
}


// MARK: View Input (View -> Presenter)
protocol ChartPresenterType: AnyObject {
    // MARK: - Properties
    var view: ChartViewType? { get set }
    var interactorInput: ChartInteractorInputType! { get set }
    var router: ChartRouterType! { get set }

    // MARK: - Methods
    func onViewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol ChartInteractorInputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods

}


// MARK: Interactor Output (Interactor -> Presenter)
protocol ChartInteractorOutputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods

}


// MARK: Router Input (Presenter -> Router)
protocol ChartRouterType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods
}