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
    private var favoriteStocks = [SingleStockViewModel]()
    private var isFavorites: Bool {
        didSet {

        }
    }

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

    func favoriteStockListItem(at index: Int) -> SingleStockViewModel {
        let item = favoriteStocks[index]
        return item
    }

    func favoriteStockListItems() -> [SingleStockViewModel] {
        favoriteStocks
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
            self.stocks = stocks
            view?.hideLoading()
            view?.didReceiveStocksList()
    }

}


