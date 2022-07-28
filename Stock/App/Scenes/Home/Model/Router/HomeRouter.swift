//
//  HomeRouter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomeRouter: HomeRouterType {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = HomeViewController()
        
        let presenter: HomePresenterType & HomeInteractorOutputType = HomePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = HomeRouter()
//        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HomeInteractor()
//        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
