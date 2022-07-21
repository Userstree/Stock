//
//  HomeViewController.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomeViewController: UIViewController {

    // MARK: - Vars & Lets
    private lazy var stockMarketCardsCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let collection = CollectionView(collectionViewLayout: flow, items: <#T##[Item]##[Item]#>, configure: <#T##@escaping (Cell, Item) -> Void##@escaping (Cell, Item) -> Swift.Void#>)
        return collection
    }()
    
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
