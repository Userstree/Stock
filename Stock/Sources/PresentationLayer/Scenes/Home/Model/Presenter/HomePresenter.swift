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
    private var homeEntity: HomeEntity?


    // MARK: - HomePresenterType Protocol
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
    func didPrepareTableViewDataSourceVM(_ homeEntity: HomeEntity){
        stocksDataSource.data = homeEntity.allStocksList
        stocksDataSource.homeEntity = homeEntity
        self.homeEntity = homeEntity
        view?.didPrepareDataManager(dataManager: stocksDataSource)
    }

    func segmentedControlValueDidChanged(to val: Int) {
        if val == 1 {
            guard let favorites = homeEntity?.favoritesStocksList else { return }
            stocksDataSource.data = favorites
        } else {
            guard let allStocks = homeEntity?.allStocksList else { return }
            stocksDataSource.data = allStocks
        }
    }

}



