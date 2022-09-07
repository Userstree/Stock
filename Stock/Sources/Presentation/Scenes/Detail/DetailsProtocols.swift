//
// Created by Dossymkhan Zhulamanov on 22.08.2022.
//


// MARK: View Output (Presenter -> View)
protocol ViewType: AnyObject {
    // MARK: - Properties
    var presenter: PresenterType! { get set }

    // MARK: - Methods
}


// MARK: View Input (View -> Presenter)
protocol PresenterType: AnyObject {
    // MARK: - Properties
    var view: ViewType? { get set }
    var interactorInput: InteractorInputType! { get set }
    var router: RouterType! { get set }

    // MARK: - Methods
    func onViewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol InteractorInputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods

}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorOutputType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods

}


// MARK: Router Input (Presenter -> Router)
protocol RouterType: AnyObject {
    // MARK: - Properties

    // MARK: - Methods
}