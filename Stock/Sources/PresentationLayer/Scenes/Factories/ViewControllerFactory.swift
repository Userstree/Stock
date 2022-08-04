//
// Created by Dossymkhan Zhulamanov on 23.07.2022.
//


final class ViewControllerFactory {
    @MainActor func instantiateHomeViewController() -> HomeViewController {
        let view = HomeViewController()
        let presenter: HomePresenterType & HomeInteractorOutputType = HomePresenter()
        let interactor: HomeInteractorInputType = HomeInteractor()
        let router: HomeRouterType = HomeRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
}
