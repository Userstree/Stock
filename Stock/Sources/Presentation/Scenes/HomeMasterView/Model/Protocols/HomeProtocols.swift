//
//  HomeProtocols.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


// MARK: View Output (Presenter -> View)
protocol HomeViewType: AnyObject {
    // MARK: - Properties
    var viewOutput: HomePresenterType! { get set }

    // MARK: - Methods
    func didReceiveStocksList()
    func didPrepareHomeEntity(_ value: HomeEntityType)
}


// MARK: View Input (View -> Presenter)
protocol HomePresenterType: AnyObject {
    // MARK: - Properties
    var view: HomeViewType? { get set }
    var interactorInput: HomeInteractorInputType! { get set }
    var router: HomeRouterType! { get set }

    // MARK: - Methods
    func onViewDidLoad()
    func didChangeQuery(_ query: String?)

    func showStockDetailsScreen(for stock: SingleStockViewModel)
//    func listSearchItem(at index: Int) -> SearchResult
    func allSearchResults() -> [SearchResult]
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol HomeInteractorInputType: AnyObject {
    // MARK: - Properties
    var interactorOutput: HomeInteractorOutputType? { get set }
    var homeEntity: HomeEntityType? { get set }

    var remoteDataRepository: RemoteDataRepositoryType? { get set }
    var localDataRepository: LocalDataRepositoryType? { get set }

    // MARK: - Methods
    func fetchStocks(for query: String)
    func fetchInitialStocks()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol HomeInteractorOutputType: AnyObject {
    // MARK: - Methods
    func didPrepareHomeEntity(_ viewModel: HomeEntityType)
    func didRetrieveSearchedCompanies(_ value: [SearchResult])
}


// MARK: Router Input (Presenter -> Router)
protocol HomeRouterType: AnyObject {
    // MARK: - Properties
//    var view: HomeViewController? { get set }

    // MARK: - Methods
    func createStockDetailsScreen(from view: HomeViewType, with viewModel: SingleStockViewModel)
}


// MARK: - Entitty
protocol HomeEntityType {
    // MARK: - Properties
    var allStocksList: [SingleStockViewModel] { get set }
    var favoritesStocksList: [SingleStockViewModel] { get set }

    // MARK: - Methods
    func appendToFavoriteStocksList(_ value: SingleStockViewModel, position: Int)
    func removeFromFavoriteStocksList(_ value: SingleStockViewModel, position: Int)

}


