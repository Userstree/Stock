//
//  FavoritesContract.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewFavoritesProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterFavoritesProtocol {
    
    var view: PresenterToViewFavoritesProtocol? { get set }
    var interactor: PresenterToInteractorFavoritesProtocol? { get set }
    var router: PresenterToRouterFavoritesProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorFavoritesProtocol {
    
    var presenter: InteractorToPresenterFavoritesProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterFavoritesProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterFavoritesProtocol {
    
}
