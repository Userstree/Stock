//
//  HomeProtocols.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


// MARK: View Output (Presenter -> View)
protocol HomeViewType: AnyObject {
    var presenter: HomePresenterType? { get set }

    // MARK: - Methods
    func didReceiveStocksList()
    func didPrepareDataManager(dataManager: StocksTableViewDataSource)
}


// MARK: View Input (View -> Presenter)
protocol HomePresenterType: AnyObject {
    var view: HomeViewType? { get set }
    var interactorInput: HomeInteractorInputType? { get set }
    var router: HomeRouterType? { get set }

    // MARK: - Methods
    func onViewDidLoad()
    func didChangeQuery(_ query: String?)
    func didSelectRow(_ index: IndexPath)
    func segmentedControlValueDidChanged(to val: Int)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol HomeInteractorInputType: AnyObject {
    var interactorOutput: HomeInteractorOutputType? { get set }
    var dataSourceViewModel: DataViewModel? { get set }

    // MARK: - Methods
    func fetchStocks(for query: String)
    func fetchInitialStocks()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol HomeInteractorOutputType: AnyObject {
    func didPrepareTableViewDataSourceVM(_ viewModel: DataViewModel)
}


// MARK: Router Input (Presenter -> Router)
protocol HomeRouterType: AnyObject {

}



