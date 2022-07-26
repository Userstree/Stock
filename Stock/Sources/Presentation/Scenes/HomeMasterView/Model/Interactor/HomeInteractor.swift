//
//  HomeInteractor.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


final class HomeInteractor: HomeInteractorInputType{
    // MARK: - Dependencies
    var remoteDataRepository: RemoteDataRepositoryType?
    var localDataRepository: LocalDataRepositoryType?


    // MARK: HomeInteractorInputType Properties
    weak var interactorOutput: HomeInteractorOutputType?
    var homeEntity: HomeEntityType?
    var searchResults: [SearchResult]?


    // MARK: - HomeInteractorInputType Protocol
    func searchStocks(for query: String) {
        remoteDataRepository?.searchStock(for: query)
        remoteDataRepository?.searchedStockCallBack = { [weak self] searchResult in
            self?.interactorOutput?.didRetrieveSearchedCompanies(searchResult)
        }
    }

    func fetchInitialStocks() {
        remoteDataRepository?.allStocksCallBack = { [weak self] viewModels in
            self?.homeEntity?.allStocksList = viewModels
            self?.interactorOutput?.didPrepareHomeEntity(self!.homeEntity!)
        }
    }


    // MARK: - Init
    init() {
    }

}



