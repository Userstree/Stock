//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class ChartModelChildAssemble {
    @MainActor class func assemble() -> ChartViewController {
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
