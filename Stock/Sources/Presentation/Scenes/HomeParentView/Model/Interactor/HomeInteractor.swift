//
//  HomeInteractor.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomeInteractor: HomeInteractorInputType{
    // MARK: - Dependencies
    var remoteDataRepository: RemoteDataRepositoryType?
    var localDataRepository: LocalDataRepositoryType?


    // MARK: HomeInteractorInputType Properties
    weak var interactorOutput: HomeInteractorOutputType?
    var homeEntity: HomeEntityType?


    // MARK: - HomeInteractorInputType Protocol
    func fetchStocks(for query: String) {

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



