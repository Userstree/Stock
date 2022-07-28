//
//  HomePresenter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomePresenter: HomePresenterType, HomeInteractorOutputType {

    // MARK: HomePresenterType Properties
    weak var view: HomeViewType?
    var interactor: HomeInteractorInputType?
    var router: HomeRouterType?

    // MARK: - Vars & Lets
    private var stocks = [StockDetails]()

    // MARK: - HomePresenterType Protocol
    func numberOfStocksItems() -> Int {
        stocks.count
    }

    func stockListItems() -> [StockViewModel] {
        let items = stocks.map { StockViewModel(stock: $0) }
        return items
    }

    func stockListItem(at index: Int) -> StockViewModel {
        let item = stocks.map { StockViewModel(stock: $0) }[index]
        return item
    }

    func onViewDidLoad() {
        view?.showLoading()
        interactor?.fetchInitialStocks()
    }

    func didChangeQuery(_ query: String?) {
    }

    func didSelectRow(_ index: IndexPath) {
    }

    // MARK: - HomeInteractorOutputType Protocol
    func didRetrieveStocksList(_ stocks: [StockDetails]) {
        self.stocks = stocks
        view?.hideLoading()
        view?.didReceiveStocksList()
    }

}

struct StockViewModel {
    let title: String
    let subTitle: String
//    let price: Int
//    let previousPrice: Int
}

extension StockViewModel {
    init(stock: StockDetails) {
        title = stock.title
        subTitle = stock.subTitle
//        price = stock.price
//        previousPrice = stock.
    }
}