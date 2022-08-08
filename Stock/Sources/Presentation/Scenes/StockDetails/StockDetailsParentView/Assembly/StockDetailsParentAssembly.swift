//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


final class StockDetailsParentAssembly {
    @MainActor class func assemble(
            for stockViewModel: SingleStockViewModel
    ) -> StockDetailsParentViewController {
        let view = StockDetailsParentViewController()
        let dataDisplayManager = StockDetailsParentDataDisplayManager()
        let interactor: StockDetailsInteractorInputType = StockDetailsInteractor()
        let presenter: StockDetailsInteractorOutputType & StockDetailsPresenterType = StockDetailsPresenter()
        let router: StockDetailsRouterType = StockDetailsRouter()
        let remoteDataRepository: RemoteDataRepositoryType = RemoteDataRepository()

        interactor.interactorOutput = presenter
        interactor.remoteDataRepository = remoteDataRepository
        view.viewOutput = presenter
        view.dataDisplayManager = dataDisplayManager
        presenter.view = view
        presenter.router = router
        presenter.interactorInput = interactor
        presenter.stockViewModel = stockViewModel
        return view
    }
}
