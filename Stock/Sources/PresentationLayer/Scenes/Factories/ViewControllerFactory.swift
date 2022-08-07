//
// Created by Dossymkhan Zhulamanov on 23.07.2022.
//


final class ViewControllerFactory {
    @MainActor func instantiateHomeViewController() -> HomeViewController {
        let view = HomeViewController()
        let presenter: HomePresenterType & HomeInteractorOutputType = HomePresenter()
        let interactor: HomeInteractorInputType = HomeInteractor()
        let router: HomeRouterType = HomeRouter()
        let dataViewModel: HomeEntity = HomeEntityImpl()
        var remoteDataRepository: RemoteDataRepository = RemoteDataRepositoryImpl()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactorInput = interactor
        interactor.interactorOutput = presenter
        interactor.homeEntity = dataViewModel
        interactor.remoteDataRepository = remoteDataRepository
        return view
    }
}
