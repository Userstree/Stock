//
//  HomeInteractor.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomeInteractor: HomeInteractorInputType {

    // MARK: - Dependencies
    private let dataManager: StocksRemoteDataManager
    private let validator = ThrottledTextValidator()

    // MARK: Properties
    weak var presenter: HomeInteractorOutputType?

    // MARK: - Init
    init(dataManager: StocksRemoteDataManager = StocksRemoteDataManager()) {
        self.dataManager = dataManager
    }
}
