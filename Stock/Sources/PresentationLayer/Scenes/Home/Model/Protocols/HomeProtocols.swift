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
    func showLoading()
    func didReceiveStocksList()
    func hideLoading()
    func changeDataSourceToFavoriteStocks()
    func changeDataSourceToAllStocks()
}


// MARK: View Input (View -> Presenter)
protocol HomePresenterType: AnyObject {
    var view: HomeViewType? { get set }
    var interactor: HomeInteractorInputType? { get set }
    var router: HomeRouterType? { get set }

    // MARK: - Methods
    func onViewDidLoad()
    func didChangeQuery(_ query: String?)
    func didSelectRow(_ index: IndexPath)

    func numberOfStocksItems() -> Int
    func allStockListItems() -> [SingleStockViewModel]
    func stockListItem(at index: Int) -> SingleStockViewModel
    func favoriteStockListItem(at index: Int) -> SingleStockViewModel
    func favoriteStockListItems() -> [SingleStockViewModel]
    func segmentedControlValueDidChanged(to val: Int)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol HomeInteractorInputType: AnyObject {
    var presenter: HomeInteractorOutputType? { get set }

    // MARK: - Methods
    func fetchStocks(for query: String)
    func fetchInitialStocks()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol HomeInteractorOutputType: AnyObject {
    func didRetrieveStocksList(_ stocks: [SingleStockViewModel])
}


// MARK: Router Input (Presenter -> Router)
protocol HomeRouterType: AnyObject {

}


// MARK: Networking
protocol StocksRemoteDataManagerProtocol: AnyObject {
    associatedtype A: Decodable
    func fetchStocks(for query: String, completion: @escaping ([A]) -> ())
    func searchStocks(for query: String, completion: @escaping ([A]) -> ())
    func getStockImage(completion: @escaping (A) -> ())
}

