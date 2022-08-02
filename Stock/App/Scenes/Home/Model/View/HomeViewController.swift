//
//  HomeViewController.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//


class HomeViewController: UIViewController, HomeViewType {

    // MARK: - HomeViewType Properties
    var presenter: HomePresenterType?

    // MARK: - HomeViewType Methods

    func showLoading() {
        displayAnimatedActivityIndicatorView()
    }

    func didReceiveStocksList() {
        tableView.reloadData()
    }

    func hideLoading() {
        hideAnimatedActivityIndicatorView()
    }


    // MARK: - Properties

    private let searchBarController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Find Company or Ticker"
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()

    private var stocksSegmentedControlView: UISegmentedControl = {
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
        return segmentedControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StocksTableViewCell.self, forCellReuseIdentifier: String(describing: StocksTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 54
        return tableView
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundColor()
        configureNavigationItems()
        configureViews()
        presenter?.onViewDidLoad()

    }

    // MARK: - Configuration of the View

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

}

extension HomeViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        presenter?.didChangeQuery(searchController.searchBar.text)
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return 0
        }
        return presenter.numberOfStocksItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StocksTableViewCell.self),
                for: indexPath) as! StocksTableViewCell
        let index = indexPath.row
        cell.titleLabel.text = presenter.stockListItem(at: index).title
        cell.subTitleLabel.text = presenter.stockListItem(at: index).subTitle
        let logo = presenter.stockListItem(at: index).logoUrlString
        if logo.isEmpty {
            cell.stockImageIcon.image = UIImage(named: "no-Image")
        }
        cell.stockImageIcon.loadImage(urlString: logo)
        return cell
    }

}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

