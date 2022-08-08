//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class SummaryModelChildAssemble {
    @MainActor class func assemble(
            with viewModel: SingleStockViewModel
    ) -> SummaryViewController {
        // MARK: - Properties
        let view = SummaryViewController()
        let presenter: SummaryPresenterType & SummaryInteractorOutputType = SummaryPresenter()
//        let router: SummaryRouterType = Summaryr
        let interactor: SummaryInteractorInputType = SummaryIneractor()
        var entity: SummaryEntityType = SummaryEntity()
        let remoteRepository: RemoteDataRepositoryType = RemoteDataRepository()

        view.viewOutput = presenter
        presenter.symbol = viewModel.title
        presenter.view = view
        presenter.interactorInput = interactor
        interactor.summaryEntity = entity
        interactor.remoteDataRepository = remoteRepository
        interactor.interactorOutput = presenter
        return view
    }
}