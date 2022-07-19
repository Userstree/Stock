//
//  SearchContract.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSearchProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchProtocol {
    
    var view: PresenterToViewSearchProtocol? { get set }
    var interactor: PresenterToInteractorSearchProtocol? { get set }
    var router: PresenterToRouterSearchProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchProtocol {
    
    var presenter: InteractorToPresenterSearchProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSearchProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSearchProtocol {
    
}
