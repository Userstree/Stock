//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class ChartModelChildAssemble {
    @MainActor class func assemble(
            with viewModel: SingleStockViewModel
    ) -> ChartViewController {
        // MARK: - Properties
        let view = ChartViewController()
        let presenter: ChartPresenterType & ChartInteractorOutputType = ChartPresenter()
        let interactor: ChartInteractorInputType = ChartInteractor()
        let router: ChartRouterType = ChartRouter()
        let chartEntity: ChartEntityType = ChartEntity()
        let summaryEntity = SummaryEntity()
        let buttonsCollectionDisplayManager = ButtonsCollectionDataManager()
        let categoriesCollectionDisplayManager = CategoriesCollectionDisplayManager()
        // Dependencies
        let remoteDataRepository: RemoteDataRepositoryType = RemoteDataRepository()
        remoteDataRepository.loadSummary(for: viewModel.title)

        view.viewOutput = presenter
        view.buttonsDataManager = buttonsCollectionDisplayManager
        view.categoriesDataManager = categoriesCollectionDisplayManager
        presenter.view = view
        presenter.router = router
        presenter.stockInitialViewModel = viewModel
        presenter.interactorInput = interactor
        interactor.interactorOutput = presenter
        interactor.chartEntity = chartEntity
        interactor.summaryEntity = summaryEntity
        return view
    }
}
