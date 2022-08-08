//
//  HomeViewController.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


final class HomeViewController: UIViewController, HomeViewType {
    // MARK: - HomeViewType Properties
    var viewOutput: HomePresenterType!

    // MARK: - HomeViewType Methods
    func didReceiveStocksList() {
        tableView.reloadData()
    }

    func didPrepareHomeEntity(_ value: HomeEntityType) {
        tableView.stopSkeletonAnimation()
        tableView.hideSkeleton()
        entity = value
        stocksTableDataDisplayManager.homeEntity = value
        stocksTableDataDisplayManager.data = value.allStocksList
        tableView.delegate = stocksTableDataDisplayManager
        tableView.reloadData()
        print("new dataSource")
    }


    // MARK: - Properties
    private var entity: HomeEntityType? {
        didSet {
            print("Entity changed")
            tableView.reloadData()
        }
    }
    var stocksTableDataDisplayManager: StocksMasterTableViewDisplayManager!

    private let searchBarController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Find Company or Ticker"
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()

    private lazy var stocksSegmentedControlView: UISegmentedControl = {
        let items = ["Stocks", "Favorites"]
        var segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        let normalStateFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        let normalStateAttributes = [NSAttributedString.Key.font: normalStateFont,
                                     NSAttributedString.Key.foregroundColor: UIColor.systemGray3]
        segmentedControl.setTitleTextAttributes(normalStateAttributes, for: .normal)
        let selectedStateFont = UIFont.systemFont(ofSize: 28, weight: .semibold)
        let selectedStateAttributes = [NSAttributedString.Key.font: selectedStateFont,
                                       NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentedControl.setTitleTextAttributes(selectedStateAttributes, for: .selected)
        segmentedControl.removeBorders()
        segmentedControl.addTarget(self, action: #selector(changedToFavorites(_:)), for: .valueChanged)
        return segmentedControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: String(describing: StockTableViewCell.self))
        tableView.register(StockTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: StockTableViewHeaderView.self))
        tableView.dataSource = stocksTableDataDisplayManager
        tableView.showsVerticalScrollIndicator = false
        tableView.isSkeletonable = true
        tableView.rowHeight = 72
        tableView.layer.cornerRadius = 12
        tableView.backgroundColor = .clear
        return tableView
    }()


    // MARK: - Actions
    @objc private func changedToFavorites(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            stocksTableDataDisplayManager.data = entity?.favoritesStocksList
            tableView.reloadData()
        } else {
            stocksTableDataDisplayManager.data = entity?.allStocksList
            tableView.reloadData()
        }
    }


    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundColor()
        configureNavigationItems()
        configureViews()
        dataDisplayConfig()
        viewOutput.onViewDidLoad()
        tableView.showAnimatedGradientSkeleton()
    }


    // MARK: - Configuration of the Views
    private func dataDisplayConfig() {
        stocksTableDataDisplayManager.onStockDidSelect = { [weak self] index in
            guard let strongSelf = self else { return }
            strongSelf.viewOutput.showStockDetails(for: strongSelf.entity!.allStocksList[index])
        }
        stocksTableDataDisplayManager.onStarDidTap = { [weak self] (section, liked) in
            guard let strongSelf = self else { return }
//            if !liked {
//                let indexPath = IndexPath(row: 0, section: section)
//                strongSelf.tableView.deleteRows(at: [indexPath], with: .fade)
//                strongSelf.tableView.reloadData()
//            }
        }
    }

    private func configureNavigationItems() {
        searchBarController.searchResultsUpdater = self
        navigationItem.searchController = searchBarController
    }

    private func configureViews() {
        [stocksSegmentedControlView,
         tableView,
        ].forEach(view.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        stocksSegmentedControlView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.leading).offset(16)
            $0.height.equalTo(32)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(stocksSegmentedControlView.snp.bottom).offset(6)
            $0.leading.equalTo(view.snp.leading).offset(16)
            $0.trailing.equalTo(view.snp.trailing).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }


    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)")
    }


    // MARK: - Deinit
    deinit {
        print("deinit home")
    }

}


extension HomeViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        viewOutput.didChangeQuery(searchController.searchBar.text)
    }
}


