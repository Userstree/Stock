//
// Created by Dossymkhan Zhulamanov on 23.07.2022.
//


final class HomeModelAssembly {
    @MainActor class func assemble() -> HomeViewController {
        // MARK: - Properties
        let view = HomeViewController()
        let presenter: HomePresenterType & HomeInteractorOutputType = HomePresenter()
        let interactor: HomeInteractorInputType = HomeInteractor()
        let router: HomeRouterType = HomeRouter()
        let homeEntity: HomeEntityType = HomeEntity()
        // Repositories
        var remoteDataRepository: RemoteDataRepositoryType = RemoteDataRepository()

        // MARK: - Methods
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactorInput = interactor
        interactor.interactorOutput = presenter
        interactor.homeEntity = homeEntity
        interactor.remoteDataRepository = remoteDataRepository
        return view
    }
}
