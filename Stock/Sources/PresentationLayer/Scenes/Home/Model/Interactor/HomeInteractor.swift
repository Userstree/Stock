//
//  HomeInteractor.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomeInteractor: HomeInteractorInputType{

    // MARK: - Dependencies
    private var dataRepository: DataRepository = DataRepositoryImpl()


    // MARK: HomeInteractorInputType Properties
    weak var interactorOutput: HomeInteractorOutputType?
    var dataSourceViewModel: DataViewModel?


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
        dataRepository.allStocks = { [weak self] viewModels in
//            self?.interactorOutput?.didRetrieveStocksList(viewModels)
            self?.dataSourceViewModel?.allStocksList = viewModels
            self?.interactorOutput?.didPrepareTableViewDataSourceVM(self!.dataSourceViewModel!)
        }
    }

    private func startFetchingStocksList(for query: String) {

    }


    // MARK: - Init
    init() {
    }

}



