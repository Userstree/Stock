//
//  FavoritesPresenter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

import Foundation

class FavoritesPresenter: ViewToPresenterFavoritesProtocol {

    // MARK: Properties
    var view: PresenterToViewFavoritesProtocol?
    var interactor: PresenterToInteractorFavoritesProtocol?
    var router: PresenterToRouterFavoritesProtocol?
}

extension FavoritesPresenter: InteractorToPresenterFavoritesProtocol {
    
}
