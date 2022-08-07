//
//  HomePresenter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

@MainActor
final class HomePresenter: HomePresenterType, HomeInteractorOutputType {
    // MARK: HomePresenterType Properties
    weak var view: HomeViewType?
    var interactorInput: HomeInteractorInputType!
    var router: HomeRouterType!


    // MARK: - Private Properties
    private var stocksTableDataDisplayManager = StocksTableViewDisplayManager()
    private var homeEntity: HomeEntityType?


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

    func showStockDetails(for stock: SingleStockViewModel) {
        router.createStockDetailsScreen()
    }


    // MARK: - HomeInteractorOutputType Protocol
    func didPrepareHomeEntity(_ homeEntity: HomeEntityType){
//        stocksTableDataDisplayManager.data = homeEntity.allStocksList
//        stocksTableDataDisplayManager.homeEntity = homeEntity
//        self.homeEntity = homeEntity
//        view?.didPrepareDataManager(dataManager: stocksTableDataDisplayManager)
        view?.didPrepareHomeEntity(homeEntity)
    }
}



