//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//


protocol DataViewModel {
    // MARK: - Properties
    var allStocksList: [SingleStockViewModel] { get set }
    var favoritesStocksList: [SingleStockViewModel] { get set }

    // MARK: - Methods
//    func changeToFavorite()
//    func changeToAll()
    func appendToFavoriteStocksList(_ value: SingleStockViewModel)
    func removeFromFavoriteStocksList(_ value: SingleStockViewModel)

}

class DataViewModelImpl: DataViewModel {

    // MARK: - DataViewModel
    var allStocksList = [SingleStockViewModel]()
    var favoritesStocksList = [SingleStockViewModel]()


    // MARK: - Methods
    func appendToFavoriteStocksList(_ value: SingleStockViewModel) {
        guard !favoritesStocksList.contains(value) else {
            return
        }
        favoritesStocksList.append(value)
    }

    func removeFromFavoriteStocksList(_ value: SingleStockViewModel) {
        guard favoritesStocksList.contains(value) else {
            return
        }
        favoritesStocksList.removeAll {
            $0 == value
        }
    }

//    func changeToFavorite()
//    func changeToAll()


    // MARK: - Init
    init() {

    }
}

typealias TableViewDataSource = UITableViewDataSource & UITableViewDelegate

class StocksTableViewDataSource: NSObject, TableViewDataSource {

    // MARK: - Properties
    var viewModel: DataViewModel?

    var data: [SingleStockViewModel] = []


    // MARK: - SkeletonTableViewDataSource
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        String(describing: StockTableViewCell.self)
    }

    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = skeletonView.dequeueReusableCell(withIdentifier: String(describing: StockTableViewCell.self), for: indexPath) as! StockTableViewCell

        return cell
    }


    // MARK: - SkeletonTableViewDelegate
    func collectionSkeletonView(_ skeletonView: UITableView, identifierForHeaderInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        String(describing: StockTableViewCell.self)
    }


    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StockTableViewCell.self),
                for: indexPath) as! StockTableViewCell
        cell.configure(viewModel:
        .init(chartViewModel: ChartViewModel(data: data[indexPath.section].candleSticks.reversed().map {
            $0.close
        },
                showLegend: false,
                showAxis: false,
                timeInterval: data[indexPath.section].candleSticks.reversed().map {
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
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: (StockTableViewHeaderView.self))) as! StockTableViewHeaderView
        headerView.configure(with: HeaderViewModel(
                title: data[section].title,
                subTitle: data[section].subTitle,
                priceLabel: "\(data[section].currentPrice)"
        ))
        headerView.isLikedCallBack = { [weak self] value in
            if value {
                self?.viewModel?.appendToFavoriteStocksList(self!.data[section])
            } else {
                self?.viewModel?.removeFromFavoriteStocksList(self!.data[section])
            }
        }
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = 12
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return headerView
    }


    // MARK: - Actions
    @objc func didTappedStarButton(_ sender: UIButton) {
        let value = sender.tag
    }


    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override init() {
        super.init()
    }

    convenience init(viewModel: DataViewModel = DataViewModelImpl()) {
        self.init()
    }

}

