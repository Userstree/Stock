//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


final class StockDetailsAssembly {
    @MainActor class func assemble(
            for stock: SingleStockViewModel
    ) -> StockDetailsViewController {
        let view = StockDetailsViewController()
        let interactor: StockDetailsInteractorInputType = StockDetailsInteractor()
        let presenter: StockDetailsInteractorOutputType & StockDetailsPresenterType & StockDetailsModuleInput = StockDetailsPresenter()
        let router: StockDetailsRouterType = StockDetailsRouter()
        let remoteDataRepository: RemoteDataRepositoryType = RemoteDataRepository()

//        configuration?(presenter)
        print("X")

        interactor.interactorOutput = presenter
        interactor.remoteDataRepository = remoteDataRepository
        view.viewOutput = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactorInput = interactor

        return view
    }

}
