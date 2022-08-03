//
//  SearchPresenter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

import Foundation

final class SearchPresenter: ViewToPresenterSearchProtocol {

    // MARK: Properties
    var view: PresenterToViewSearchProtocol?
    var interactor: PresenterToInteractorSearchProtocol?
    var router: PresenterToRouterSearchProtocol?
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    
}
