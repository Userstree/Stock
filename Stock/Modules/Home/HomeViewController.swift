//
//  HomeViewController.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Vars & Lets
//    private lazy var
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundColor()

    }

    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol?
    
}

extension HomeViewController: PresenterToViewHomeProtocol{
    // TODO: Implement View Output Methods
}
