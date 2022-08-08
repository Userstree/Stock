//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


import Charts

final class ChartViewController: UIViewController, ChartViewType {
    // MARK: - ChartViewType Protocol Properties
    var viewOutput: ChartPresenterType!


    // MARK: - ChartViewType Protocol Methods
    func didPassStockViewModel(_ value: SingleStockViewModel) {
        stockViewModel = value
        configure(with: ChartViewModel(data: value.candleSticks.reversed().map { $0.close },
                                        showLegend: true,
                                        showAxis: true,
                                        timeInterval: value.candleSticks.reversed().map{ $0.timeInterval })
        )
    }


    // MARK: - Properties
    private var stockViewModel: SingleStockViewModel!
    var buttonsDataManager: ButtonsCollectionDataManager!

    private lazy var chart: StockChartView = {
        let chart = StockChartView()
        chart.isUserInteractionEnabled = false
        chart.clipsToBounds = true
        chart.isSkeletonable = true
        return chart
    }()

    private lazy var buttonsHolderCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.isScrollEnabled = false
        collection.register(TimeButtonCollectionCell.self,
                forCellWithReuseIdentifier: String(describing: TimeButtonCollectionCell.self))
        collection.delegate = buttonsDataManager
        collection.dataSource = buttonsDataManager
        return collection
    }()

    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy for \(stockViewModel.currentPrice)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = R.color.button()!
        button.contentEdgeInsets = UIEdgeInsets(top: 24, left: 10, bottom: 24, right: 10)
        button.layer.cornerCurve = .continuous
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
//        button.setTitleColor(R.color.text()!, for: .highlighted)
        return button
    }()


    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput.onViewDidLoad()
        configureNavigationItems()
        configureViews()
        buttonCollectionActions()
    }


    // MARK: - Actions
    private func buttonCollectionActions() {
        buttonsDataManager.onButtonTapped = { [weak self] stringVal in
            print(stringVal)
        }
    }

    @objc private func didTapBuyButton(){
        print("bought")
    }


    // MARK: - Configuration of the Views
    private func configureNavigationItems() {

    }

    private func configureViews() {
        [
            chart,
            buttonsHolderCollection,
            buyButton,
        ].forEach(view.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        chart.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(18)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.height.equalTo(334)
        }
        buttonsHolderCollection.snp.makeConstraints {
            $0.top.equalTo(chart.snp.bottom).offset(8)
            $0.leading.equalTo(chart.snp.leading)
            $0.trailing.equalTo(chart.snp.trailing)
            $0.height.equalTo(40)
        }
        buyButton.snp.makeConstraints {
            $0.top.equalTo(buttonsHolderCollection.snp.bottom).offset(8)
            $0.leading.equalTo(chart.snp.leading).offset(16)
            $0.trailing.equalTo(chart.snp.trailing).offset(-16)
            $0.height.equalTo(30)
        }
    }


    // MARK: - Methods
    func configure(with viewModel: ChartViewModel) {
        var entries = [ChartDataEntry]()

        for (index, value) in viewModel.data.enumerated() {
            entries.append(.init(x: Double(index),
                    y: value))
        }
        chart.chartView.rightAxis.enabled = viewModel.showAxis
        chart.chartView.legend.enabled = viewModel.showLegend

        let gradientColors = [UIColor.systemRed.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)

        let dataSet = LineChartDataSet(entries: entries, label: "3 days ")
        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.fillAlpha = 0.2
        dataSet.lineWidth = 1
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.setColors(.red)

        let data = LineChartData(dataSet: dataSet)
        chart.chartView.data = data
    }


    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)")
    }

}