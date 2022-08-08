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
        router.createStockDetailsScreen(from: view!, with: stock)
    }


    // MARK: - HomeInteractorOutputType Protocol
    func didPrepareHomeEntity(_ homeEntity: HomeEntityType){
        view?.didPrepareHomeEntity(homeEntity)
    }
}



