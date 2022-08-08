//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//



// MARK: View Output (Presenter -> View)
protocol NewsViewType: AnyObject {
    // MARK: - Properties
    var presenter: NewsPresenterType! { get set }

    // MARK: - Methods
}


// MARK: View Input (View -> Presenter)
protocol NewsPresenterType: AnyObject {
    // MARK: - Properties
    var view: NewsViewType? { get set }
    var interactorInput: NewsInteractorInputType! { get set }
    var router: NewsRouterType! { get set }

    // MARK: - Methods
    func onViewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol NewsInteractorInputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods

}


// MARK: Interactor Output (Interactor -> Presenter)
protocol NewsInteractorOutputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods

}


// MARK: Router Input (Presenter -> Router)
protocol NewsRouterType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods
}
