//
//  SearchRouter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

import Foundation
import UIKit

class SearchRouter: PresenterToRouterSearchProtocol {
    
    // MARK: Static methods
    @MainActor static func createModule() -> UIViewController {
        
        let viewController = SearchViewController()
        
        let presenter: ViewToPresenterSearchProtocol & InteractorToPresenterSearchProtocol = SearchPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SearchRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SearchInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
