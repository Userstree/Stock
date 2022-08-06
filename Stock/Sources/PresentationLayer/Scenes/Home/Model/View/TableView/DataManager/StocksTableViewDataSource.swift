//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//

import SkeletonView

protocol DataViewModel {
    var allStocksList: [SingleStockViewModel] { get set }
    var favoritesStocksList: [SingleStockViewModel] { get set }
}

class DataViewModelImpl: DataViewModel {
    var allStocksList = [SingleStockViewModel]()
    var favoritesStocksList = [SingleStockViewModel]()

    init() {

    }
}

typealias TableViewDataSource = UITableViewDataSource & UITableViewDelegate
fileprivate typealias SkeletonableTableView = SkeletonTableViewDataSource & SkeletonTableViewDelegate

class StocksTableViewDataSource: NSObject, TableViewDataSource, SkeletonableTableView {

    var viewModel: DataViewModel? {
        didSet {
            data = viewModel!.allStocksList
        }
    }
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

    public func numberOfSections(in tableView: UITableView) -> Int {
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
        )
        )
        headerView.clipsToBounds = true
        headerView.isFavoriteCallBack = {[weak self] liked in
            headerView.isFavorite = liked
            print(liked, section)
        }
        return headerView
    }

    // MARK: - Actions
    @objc func didTappedStarButton(_ sender: UIButton) {
        let value = sender.tag
//        presenter?.segmentedControlValueDidChanged(to: value)
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    override init() {
        super.init()
    }

    convenience init(viewModel: DataViewModel = DataViewModelImpl()) {
        self.init()
        self.viewModel = viewModel
    }

}

