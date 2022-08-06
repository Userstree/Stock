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
    var interactorInput: HomeInteractorInputType?
    var router: HomeRouterType?


    // MARK: - Vars & Lets
    private var stocksDataSource = StocksTableViewDataSource()
    private var viewModel: DataViewModel?

    // MARK: - HomePresenterType Protocol

//    func numberOfStocksItems() -> Int {
//        stocks.count
//    }
//
//    func allStockListItems() -> [SingleStockViewModel] {
//        stocks
//    }
//
//    func stockListItem(at index: Int) -> SingleStockViewModel {
//        let item = stocks[index]
//        return item
//    }
//
//    func favoriteStockListItem(at index: Int) -> SingleStockViewModel {
//        let item = favoriteStocks[index]
//        return item
//    }
//
//    func favoriteStockListItems() -> [SingleStockViewModel] {
//        favoriteStocks
//    }

    func onViewDidLoad() {
        interactorInput?.fetchInitialStocks()
    }

    func didChangeQuery(_ query: String?) {
        guard let query = query else {
            return
        }
        interactorInput?.fetchStocks(for: query)
    }

    func didSelectRow(_ index: IndexPath) {

    }


    // MARK: - HomeInteractorOutputType Protocol

    func didPrepareTableViewDataSourceVM(_ viewModel: DataViewModel){
        stocksDataSource.data = viewModel.allStocksList
        stocksDataSource.viewModel = viewModel
        self.viewModel = viewModel
        view?.didPrepareDataManager(dataManager: stocksDataSource)
    }

    func segmentedControlValueDidChanged(to val: Int) {
        if val == 1 {
            guard let favorites = viewModel?.favoritesStocksList else { return }
            stocksDataSource.data = favorites
        } else {
            guard let allStocks = viewModel?.allStocksList else { return }
            stocksDataSource.data = allStocks
        }
    }

}



