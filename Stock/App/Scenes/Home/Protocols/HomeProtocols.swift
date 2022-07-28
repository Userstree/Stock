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
//    func displayAlert()
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
    func stockListItems() -> [StockViewModel]
    func stockListItem(at index: Int) -> StockViewModel
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol HomeInteractorInputType: AnyObject {
    var presenter: HomeInteractorOutputType? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol HomeInteractorOutputType: AnyObject {

}


// MARK: Router Input (Presenter -> Router)
protocol HomeRouterType: AnyObject {

}


// MARK: Networking
protocol StocksRemoteDataManagerProtocol: AnyObject {
//    func fetchStocks<A: Decodable>(for query: String, completion: @escaping ([A]) -> ())
    associatedtype A: Decodable
    func fetchStocks(for query: String, completion: @escaping ([A]) -> ())
}

