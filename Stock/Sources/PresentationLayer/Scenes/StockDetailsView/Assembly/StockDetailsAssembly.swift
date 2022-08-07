//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


final class StockDetailsAssembly {

    @MainActor class func assemble() -> StockDetailsViewController {
        let view = StockDetailsViewController()
        let interactor: StockDetailsInteractorInputType = StockDetailsInteractor()
        let presenter: StockDetailsInteractorOutputType & StockDetailsPresenterType = StockDetailsPresenter()


        return view
    }

}
