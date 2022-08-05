//
//  HomePresenter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

@MainActor
class HomePresenter: HomePresenterType, HomeInteractorOutputType {

    // MARK: HomePresenterType Properties
    weak var view: HomeViewType?
    var interactor: HomeInteractorInputType?
    var router: HomeRouterType?

    // MARK: - Vars & Lets
    private var stocksDataSource = StocksTableViewDataSource()
    private var stocks = [SingleStockViewModel]()
    private var favoriteStocks = [SingleStockViewModel]()
    private var isFavorites: Bool = false {
        didSet {
            if isFavorites {
                favoriteStockListItems()
            } else {

            }
        }
    }

    // MARK: - HomePresenterType Protocol

    func numberOfStocksItems() -> Int {
        stocks.count
    }

    func allStockListItems() -> [SingleStockViewModel] {
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

    func segmentedControlValueDidChanged(to val: Int) {
        if val == 1 {
            isFavorites = true
        } else {
            isFavorites = false
        }
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

    func didPrepareTableViewDataSourceVM(_ viewModel: DataViewModel) {
        stocksDataSource.viewModel = viewModel
    }
}


