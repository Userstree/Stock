//
//  HomeInteractor.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomeInteractor: HomeInteractorInputType{

    // MARK: - Dependencies
    var remoteDataRepository: RemoteDataRepository?
    var localDataRepository: LocalDataRepository?


    // MARK: HomeInteractorInputType Properties
    weak var interactorOutput: HomeInteractorOutputType?
    var homeEntity: HomeEntity?


    // MARK: - HomeInteractorInputType Protocol
    func fetchStocks(for query: String) {
//        if query.isEmpty {
//            startFetchingStocksList(for: "appl")
//        } else {
//            validator.validate(query: query) { [weak self] query in
//                guard let strongSelf = self,
//                      let query = query
//                else {
//                    return
//                }
//                strongSelf.startFetchingStocksList(for: query)
//            }
//        }
    }

    func fetchInitialStocks() {
        remoteDataRepository?.allStocksCallBack = { [weak self] viewModels in
            self?.homeEntity?.allStocksList = viewModels
            self?.interactorOutput?.didPrepareTableViewDataSourceVM(self!.homeEntity!)
        }
    }

    private func startFetchingStocksList(for query: String) {

    }


    // MARK: - Init
    init() {
    }

}



