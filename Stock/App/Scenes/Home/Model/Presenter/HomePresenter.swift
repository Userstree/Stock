//
//  HomePresenter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomePresenter: HomePresenterType {

    // MARK: Properties
    var view: HomeViewType?
    var interactor: HomeInteractorInputType?
    var router: HomeRouterType?
}

extension HomePresenter: HomeInteractorOutputType {
    
}
