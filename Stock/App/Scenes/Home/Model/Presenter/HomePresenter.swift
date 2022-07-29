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
    private var stocks = [StockDetailsModellable]()
    private var stocksImageURLStrings = [String]()

    // MARK: - HomePresenterType Protocol
    func numberOfStocksItems() -> Int {
        stocks.count
    }

    func stockListItems() -> [StockViewModel] {
        let items = self.stocks.map { StockViewModel(stock: $0) }
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
        guard let query = query else { return }
        view?.showLoading()
        interactor?.fetchStocks(for: query)
    }

    func didSelectRow(_ index: IndexPath) {
    }

    // MARK: - HomeInteractorOutputType Protocol
    func didRetrieveStocksList(_ stocks: [StockDetailsModellable]) {
        self.stocks = stocks
        view?.hideLoading()
        view?.didReceiveStocksList()
    }
    func didRetrieveStocksImageURLStrings(){

    }
}

struct StockViewModel{
    var title: String
    var subTitle: String
}

extension StockViewModel {
    init(stock: StockDetailsModellable) {
        title = stock.title
        subTitle = stock.subTitle
    }
}
