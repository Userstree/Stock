//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//


import SkeletonView


class StockTableViewCell: UITableViewCell {
    // MARK: - ViewModel
    struct CellViewModel{
        let chartViewModel: ChartViewModel
    }

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

        makeConstraints()
    }

    private func makeConstraints() {
        chart.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }

    func configure(viewModel: CellViewModel) {
        chart.configure(with: viewModel.chartViewModel)
        contentView.clipsToBounds = true
        contentView.addSubview(chart)
    }

}

