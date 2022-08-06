//
//  HomeViewController.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

import SkeletonView

class HomeViewController: UIViewController, HomeViewType {

    // MARK: - HomeViewType Properties
    var presenter: HomePresenterType?


    // MARK: - HomeViewType Methods
    func showLoading() {
//        displayAnimatedActivityIndicatorView()
    }

    func didReceiveStocksList() {
        tableView.reloadData()
    }

    func hideLoading() {
//        hideAnimatedActivityIndicatorView()
    }

    // MARK: - Star State
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
//                starImageView.setImage(UIImage(systemName: "star.fill")!)
            } else {
//                starImageView.setImage(UIImage(systemName: "star")!)
            }
        }
    }

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
        segmentedControl.addTarget(self, action: #selector(didchangedToFavorites(_:)), for: .valueChanged)
        return segmentedControl
    }()


    // MARK: - Actions
    @objc private func didchangedToFavorites(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            presenter?.segmentedControlValueDidChanged(to: 1)
        } else {
            presenter?.segmentedControlValueDidChanged(to: 0)
        }
    }


    // MARK: - TableViewDataManager
    private var stocksTableViewDataSource = StocksTableViewDataSource()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: String(describing: StockTableViewCell.self))
        tableView.register(StockTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: StockTableViewHeaderView.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 72
        tableView.layer.cornerRadius = 12
        tableView.backgroundColor = .clear
        return tableView
    }()


    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundColor()
        tableView.isSkeletonable = true
        tableView.showSkeleton(usingColor: .wetAsphalt, transition: .crossDissolve(0.25))
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

    func didPrepareDataManager(dataManager: StocksTableViewDataSource) {
        tableView.stopSkeletonAnimation()
        tableView.hideSkeleton()
        tableView.dataSource = dataManager
        print("new dataSource")
    }
}

extension HomeViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        presenter?.didChangeQuery(searchController.searchBar.text)
    }

}

extension HomeViewController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let presenter = presenter else {
            return 0
        }
        return presenter.numberOfStocksItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StockTableViewCell.self),
                for: indexPath) as! StockTableViewCell
        cell.configure(viewModel:
        .init(chartViewModel: ChartViewModel(data: presenter.stockListItem(at: indexPath.section).candleSticks.reversed().map {
            $0.close
        },
                showLegend: false,
                showAxis: false,
                timeInterval: presenter.stockListItem(at: indexPath.section).candleSticks.reversed().map {
                    $0.timeInterval
                }
        )))
        cell.layer.cornerRadius = 12
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        cell.backgroundColor = R.color.cellBodyBackground()!
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let presenter = presenter else {
            return UITableViewCell()
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: (StockTableViewHeaderView.self))) as! StockTableViewHeaderView
        headerView.configure(with: HeaderViewModel(
                title: presenter.stockListItem(at: section).title,
                subTitle: presenter.stockListItem(at: section).subTitle,
                priceLabel: "\(presenter.stockListItem(at: section).currentPrice)"
        )
        )
        headerView.clipsToBounds = true
        headerView.isFavoriteCallBack = { [weak self] liked in
            headerView.isFavorite = liked
            print(liked, section)
        }
        return headerView
    }

    public func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        String(describing: StockTableViewCell.self)
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

