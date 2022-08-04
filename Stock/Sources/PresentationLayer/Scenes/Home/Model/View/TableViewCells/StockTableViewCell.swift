//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//


class StockTableViewCell: UITableViewCell {
    // MARK: - ViewModel
    struct CellViewModel{
        let chartViewModel: ChartViewModel
    }

    lazy var chart: StockChartView = {
        let chart = StockChartView()
        chart.isUserInteractionEnabled = false
        chart.clipsToBounds = true
        return chart
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(chart)
    }

    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder) in cell")
    }

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
    }
}

