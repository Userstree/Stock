//
//  FavoritesRouter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

import Foundation
import UIKit

class FavoritesRouter: PresenterToRouterFavoritesProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = FavoritesViewController()
        
        let presenter: ViewToPresenterFavoritesProtocol & InteractorToPresenterFavoritesProtocol = FavoritesPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = FavoritesRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = FavoritesInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
