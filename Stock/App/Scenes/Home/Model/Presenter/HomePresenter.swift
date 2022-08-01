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
    private var stocks = [SingleStockViewModel]()
    private var stocksImageURLStrings = [String]()

    // MARK: - HomePresenterType Protocol

    func numberOfStocksItems() -> Int {
        stocks.count
    }

    func stockListItems() -> [SingleStockViewModel] {
        stocks
    }

    func stockListItem(at index: Int) -> SingleStockViewModel {
        let item = stocks[index]
        return item
    }

    func onViewDidLoad() {
        view?.showLoading()
        interactor?.fetchInitialStocks()

    }

    func didChangeQuery(_ query: String?) {
        guard let query = query else {
            return
        }
        interactor?.fetchStocks(for: query)
    }

    func didSelectRow(_ index: IndexPath) {
    }

    // MARK: - HomeInteractorOutputType Protocol

    func didRetrieveStocksList(_ stocks: [SingleStockViewModel]) {
        DispatchQueue.main.async { [weak self, weak view] in
            guard let self = self else { return }
            self.stocks = stocks
            view?.hideLoading()
            view?.didReceiveStocksList()
        }
    }

    func didRetrieveStocksImageURLStrings() {

    }

}


struct StockViewModel {
    var title: String
    var subTitle: String
}

extension StockViewModel {
    init(stock: StockDetailsModellable) {
        title = stock.title
        subTitle = stock.subTitle
    }
}
