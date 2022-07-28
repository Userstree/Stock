//
//  HomeViewController.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomeViewController: UIViewController {

    // MARK: - Vars & Lets
//    private lazy var marketIndexesCollection: UICollectionView = {
//        let flow = UICollectionViewFlowLayout()
//        flow.scrollDirection = .horizontal
//        let collection = CollectionView(collectionViewLayout: flow, items: ["Card1","Card2"], configure: { (cell: MarketIndexCell, item) in
////            cell.
//        })
//        return collection.collectionView
//    }()

    private let searchBarController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Find Company or Ticker"
        return searchController
    }()

//    private var stocksListChanger: UISegmentedControl = {
//
//    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundColor()
        configureNavigationItems()
        configureViews()
    }

    // MARK: - Properties
    var presenter: HomePresenterType?

    // MARK: - Configuration of the View

    private func configureNavigationItems() {
        searchBarController.searchResultsUpdater = self
        navigationItem.searchController = searchBarController
    }

    private func configureViews() {

        makeConstraints()
    }

    private func makeConstraints(){

    }

    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)")
    }
}

extension HomeViewController: HomeViewType{
    // TODO: Implement View Output Methods
}

extension HomeViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}