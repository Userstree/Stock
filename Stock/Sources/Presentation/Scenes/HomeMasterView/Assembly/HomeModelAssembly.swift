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
        var stocksTableDataDisplayManager = StocksTableViewDisplayManager()
        // Repositories
        let remoteDataRepository: RemoteDataRepositoryType = RemoteDataRepository()
        remoteDataRepository.loadViewModelsFromWeb()
        let localDataRepository: LocalDataRepositoryType = LocalDataRepository()

        // MARK: - Methods
        view.viewOutput = presenter
        view.stocksTableDataDisplayManager = stocksTableDataDisplayManager
        presenter.view = view
        presenter.router = router
        presenter.interactorInput = interactor
        interactor.interactorOutput = presenter
        interactor.homeEntity = homeEntity
        interactor.remoteDataRepository = remoteDataRepository
        interactor.localDataRepository = localDataRepository
        return view
    }
}
