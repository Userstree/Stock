//
//  SearchViewController.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterSearchProtocol?
    
}

extension SearchViewController: PresenterToViewSearchProtocol{
    // TODO: Implement View Output Methods
}
