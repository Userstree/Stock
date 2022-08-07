//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//


typealias TableViewDataSource = UITableViewDataSource & UITableViewDelegate

class StocksTableViewDataSource: NSObject, TableViewDataSource {

    // MARK: - Properties
    var homeEntity: HomeEntity?

    var data: [SingleStockViewModel] = []


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
                priceLabel: "\(data[section].currentPrice)",
                isLiked: data[section].isLiked
        ))
        headerView.isLikedCallBack = { [weak self] liked in
            self?.data[section].isLiked = liked
            if liked {
                self?.homeEntity?.appendToFavoriteStocksList(self!.data[section], position: section)
            } else {
                self?.homeEntity?.removeFromFavoriteStocksList(self!.data[section], position: section)
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

    convenience init(viewModel: HomeEntity = HomeEntityImpl()) {
        self.init()
    }

}

