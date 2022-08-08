//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//


typealias SkeletonableTableView = SkeletonTableViewDataSource & SkeletonTableViewDelegate
typealias TableViewDataSource = UITableViewDataSource & UITableViewDelegate

class StocksTableViewDisplayManager: NSObject, SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    // MARK: - Properties
    var homeEntity: HomeEntityType?
    var data: [SingleStockViewModel]?
    var onStockDidSelect: ((Int) -> Void)?


    // MARK: - SkeletonTableViewDataSource
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        String(describing: StockTableViewCell.self)
    }

    public func collectionSkeletonView(_ skeletonView: UITableView, identifierForHeaderInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        String(describing: StockTableViewHeaderView.self)
    }

    public func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UITableView.automaticNumberOfSkeletonRows
    }

    public func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = skeletonView.dequeueReusableCell(withIdentifier: String(describing: StockTableViewCell.self), for: indexPath) as? StockTableViewCell
        cell?.configure(viewModel: .skeletonable)
        cell?.isSkeletonable = true
        return cell
    }


    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        data?.count ?? 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StockTableViewCell.self),
                for: indexPath) as! StockTableViewCell
        guard let data = data else {
            cell.configure(viewModel: .skeletonable)
            return cell
        }
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
        guard let data = data else {
            headerView.isSkeletonable = true
            headerView.configure(with: .skeletonable)
            return headerView
        }
        headerView.configure(with: HeaderViewModel(
                title: data[section].title,
                subTitle: data[section].subTitle,
                priceLabel: "\(data[section].currentPrice)",
                isLiked: data[section].isLiked
        ))
        headerView.isLikedCallBack = { [weak self] liked in
            self?.data?[section].isLiked = liked
            if liked {
                self?.homeEntity?.appendToFavoriteStocksList(self!.data![section], position: section)
            } else {
                self?.homeEntity?.removeFromFavoriteStocksList(self!.data![section], position: section)
            }
        }
        headerView.clipsToBounds = true
        guard section != 0 else { return headerView}
        headerView.layer.cornerRadius = 12
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return headerView
    }


    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onStockDidSelect?(indexPath.section)
    }

    override init() {
        super.init()
    }

    convenience init(viewModel: HomeEntityType = HomeEntity()) {
        self.init()
    }

}

