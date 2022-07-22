//
//  FavoritesViewController.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class FavoritesViewController: UIViewController {



    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Properties
    var presenter: ViewToPresenterFavoritesProtocol?
    
}

extension FavoritesViewController: PresenterToViewFavoritesProtocol{
    // TODO: Implement View Output Methods
}
