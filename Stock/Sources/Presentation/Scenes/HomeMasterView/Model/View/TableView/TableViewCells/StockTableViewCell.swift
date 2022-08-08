//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//


protocol SkeletonaableViewModel {
    associatedtype ViewModel = Self
    static var skeletonable: ViewModel { get }
}

class StockTableViewCell: UITableViewCell {
    // MARK: - ViewModel
    struct CellViewModel: SkeletonaableViewModel {
        let chartViewModel: ChartViewModel
        static var skeletonable: Self = .init(chartViewModel: .init(data: [], showLegend: false, showAxis: false, priceChange: 0.23, timeInterval: []))
    }

    lazy var priceChangeLabel = UILabel()
            .font(ofSize: 14, weight: .regular)
            .cornerRadius(6)
            .clipsToBounds(true)
            .isSkeletonable(true)
            .textAlignment(.center)


    lazy var chart: StockChartView = {
        let chart = StockChartView()
        chart.isUserInteractionEnabled = false
        chart.clipsToBounds = true
        chart.isSkeletonable = true
        return chart
    }()

    // MARK: - Controller lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        chart.reset()
    }

    // MARK: - Configuration of the View
    private func configureViews() {
        [
            priceChangeLabel,
            chart,
        ].forEach(contentView.addSubview)
        contentView.isSkeletonable = true
        makeConstraints()
    }

    private func makeConstraints() {
        priceChangeLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(4)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-4)
            $0.size.equalTo(CGSize(width: 58, height: 26))
        }
        chart.snp.makeConstraints {
            $0.top.equalTo(priceChangeLabel.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }

    func configure(viewModel: CellViewModel) {
        chart.configure(with: viewModel.chartViewModel)
        contentView.clipsToBounds = true
        contentView.addSubview(chart)
        guard var price = viewModel.chartViewModel.priceChange else { return }
        if price >= 0 {
            priceChangeLabel.backgroundColor = .systemGreen
        } else {
            priceChangeLabel.backgroundColor = .systemRed
            priceChangeLabel.textColor = .white
        }
        priceChangeLabel.text = String(format: "%.2f%%", price * 100)
    }

}

