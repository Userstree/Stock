//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//


class StocksTableViewDataSource: NSObject, UITableViewDataSource {

//    var allStocksList = [SingleStockViewModel]()
//    var favoritesStocksList = [SingleStockViewModel]()
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1
//    }
//
//    public func numberOfSections(in tableView: UITableView) -> Int {
//        return presenter.numberOfStocksItems()
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let presenter = presenter else {
//            return UITableViewCell()
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StockTableViewCell.self),
//                for: indexPath) as! StockTableViewCell
//        cell.configure(viewModel:
//        .init(chartViewModel: ChartViewModel(data: presenter.stockListItem(at: indexPath.section).candleSticks.reversed().map { $0.close },
//                showLegend: false,
//                showAxis: false,
//                fillColor: .systemRed,
//                timeInterval: presenter.stockListItem(at: indexPath.section).candleSticks.reversed().map { $0.timeInterval }
//        )))
//        cell.layer.cornerRadius = 12
//        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//        cell.backgroundColor = R.color.cellBodyBackground()!
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        60
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let presenter = presenter else {
//            return UITableViewCell()
//        }
//        let header = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
//        header.backgroundColor = R.color.cellHeaderBackground()
//        header.clipsToBounds = true
//
//        // MARK: - Star State
//        var isFavorite: Bool = false {
//            didSet {
//                if isFavorite {
//                    starImageView.image = UIImage(systemName: "star.fill")
//                } else {
//                    starImageView.image = UIImage(systemName: "star")
//                }
//            }
//        }
//
//        let titleLabel = UILabel()
//                .text(presenter.stockListItem(at: section).title)
//                .textColor(R.color.cellTitleLabelColor()!)
//                .font(ofSize: 18, weight: .bold)
//
//        let subTitleLabel = UILabel()
//                .text(presenter.stockListItem(at: section).subTitle)
//                .textColor(R.color.cellTitleLabelColor()!)
//                .font(ofSize: 11, weight: .regular)
//
//        var starImageView: UIImageView = {
//            let imageView = UIImageView(image: UIImage(systemName: "star"))
//            imageView.tintColor = .systemYellow
//            imageView.isUserInteractionEnabled = true
//            return imageView
//        }()
//
//        let priceLabel = UILabel()
//                .text(String(format: "%.2f", presenter.stockListItem(at: section).currentPrice))
//                .textColor(.white)
//                .font(ofSize: 15, weight: .bold)
//        priceLabel.transform = CGAffineTransform(rotationAngle: 0.56)
//
//        let priceBackgroundImage = UIImage(systemName: "app.badge.fill")
//        let labelImageView = UIImageView(image: priceBackgroundImage!)
//                .tintColor(R.color.cellLabelBackground()!)
//                .contentMode(.scaleToFill)
//
//        // MARK: - Actions
//        [
//            titleLabel,
//            subTitleLabel,
//            labelImageView,
//            priceLabel,
//            starImageView,
//        ].forEach(header.addSubview)
//
//        titleLabel.snp.makeConstraints {
//            $0.leading.equalTo(header.snp.leading).offset(8)
//            $0.top.equalTo(header.snp.top).offset(8)
//        }
//
//        subTitleLabel.snp.makeConstraints {
//            $0.leading.equalTo(titleLabel.snp.leading)
//            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
//        }
//
//        starImageView.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.top).offset(0)
//            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
//            $0.bottom.equalTo(titleLabel.snp.bottom)
//            $0.width.equalTo(25)
//        }
//
//        labelImageView.snp.makeConstraints {
//            $0.trailing.equalTo(header.snp.trailing).offset(10)
//            $0.top.equalTo(header.snp.top).offset(-10)
//            $0.bottom.equalTo(header.snp.bottom).offset(-15)
//            $0.width.equalTo(70)
//        }
//
//        priceLabel.snp.makeConstraints {
//            $0.center.equalTo(labelImageView.snp.center)
//        }
//        header.layer.cornerRadius = 12
//        header.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        return header
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("tableView(_:numberOfRowsInSection:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("tableView(_:cellForRowAt:) has not been implemented")
    }
}
