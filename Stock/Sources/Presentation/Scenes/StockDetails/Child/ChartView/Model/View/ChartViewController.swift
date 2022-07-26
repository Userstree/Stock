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
        configure(with: ChartViewModel(data: value.candleSticks.reversed().map {
            $0.close
        },
                showLegend: true,
                showAxis: true,
                priceChange: value.priceChange,
                timeInterval: value.candleSticks.reversed().map {
                    $0.timeInterval
                })
        )
    }

    func didPrepareCompanySummary(_ value: CompanySummary) {
        pricesStack.industryLabel.text = (value.finnhubIndustry)
    }


    // MARK: - Properties
    private var stockViewModel: SingleStockViewModel!

    var buttonsDataManager: ButtonsCollectionDataManager!

    private lazy var pricesStack: PriceLabelsView = {
        let stack = PriceLabelsView()
        stack.priceLabel.text = String(format: "$%.2f%", stockViewModel.currentPrice)
        stack.priceChangeLabel.text = String(format: "%.2f%%", stockViewModel.priceChange * 100)
        if stockViewModel.priceChange >= 0 {
            stack.changeIndicatorImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            stack.changeIndicatorImageView.tintColor = .systemGreen
            stack.priceChangeLabel.textColor = .systemGreen
        } else {
            stack.changeIndicatorImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            stack.changeIndicatorImageView.tintColor = .systemRed
            stack.priceChangeLabel.textColor = .systemRed
        }
        return stack
    }()

    private lazy var chart: StockChartView = {
        let chart = StockChartView()
        chart.isUserInteractionEnabled = false
        chart.clipsToBounds = true
        chart.isSkeletonable = true
        return chart
    }()

    private lazy var buttonsAnnotationLabel = UILabel()
            .text("Choose the timeframe: ")
            .textColor(.black)
            .textAlignment(.left)
            .font(ofSize: 16, weight: .regular)

    private lazy var buttonsHolderCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 32
        flowLayout.minimumLineSpacing = 32
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.isScrollEnabled = false
        collection.register(TimeButtonCollectionCell.self,
                forCellWithReuseIdentifier: String(describing: TimeButtonCollectionCell.self))
        collection.delegate = buttonsDataManager
        collection.dataSource = buttonsDataManager
        return collection
    }()

    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy for $\(stockViewModel.currentPrice)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = R.color.button()!
        button.titleEdgeInsets = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        button.layer.cornerCurve = .continuous
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        return button
    }()


    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput.onViewDidLoad()
        configureViews()
        collectionButtonTapped()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buttonsHolderCollection.selectItem(at: .some(IndexPath(row: 0, section: 0)), animated: false, scrollPosition: .top)
    }


    // MARK: - Actions
    private func collectionButtonTapped() {
        buttonsDataManager.onTappedToString = { [unowned self] value in
            self.viewOutput.chartTimeFrameRequest(for: value)
        }
    }

    @objc private func didTapBuyButton() {
        print("bought")
    }

    private func configureViews() {
        [
            pricesStack,
            chart,
            buttonsHolderCollection,
            buttonsAnnotationLabel,
            buyButton,
        ].forEach(view.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        pricesStack.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(26)
            $0.leading.equalTo(view.snp.leading).offset(16)
            $0.size.equalTo(CGSize(width: view.frame.width, height: 65))
        }
        chart.snp.makeConstraints {
            $0.top.equalTo(pricesStack.snp.bottom).offset(45)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.height.equalTo(view.frame.height * (1 / 3))
        }
        buttonsAnnotationLabel.snp.makeConstraints {
            $0.top.equalTo(chart.snp.bottom).offset(20)
            $0.leading.equalTo(chart.snp.leading).offset(16)
            $0.trailing.equalTo(chart.snp.trailing)
            $0.height.equalTo(20)
        }
        buttonsHolderCollection.snp.makeConstraints {
            $0.top.equalTo(buttonsAnnotationLabel.snp.bottom)
            $0.leading.equalTo(chart.snp.leading).offset(16)
            $0.trailing.equalTo(chart.snp.trailing)
            $0.height.equalTo(44)
        }
        buyButton.snp.makeConstraints {
            $0.top.equalTo(buttonsHolderCollection.snp.bottom).offset(32)
            $0.leading.equalTo(chart.snp.leading).offset(16)
            $0.trailing.equalTo(chart.snp.trailing).offset(-16)
            $0.height.equalTo(44)
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
        var gradientColors = [UIColor.black.cgColor, UIColor.clear.cgColor] as CFArray
        if let price = viewModel.priceChange, price >= 0.0 {
            gradientColors = [UIColor.green.cgColor, UIColor.clear.cgColor] as CFArray
        } else {
            gradientColors = [UIColor.red.cgColor, UIColor.clear.cgColor] as CFArray
        }
        let colorLocations: [CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)

        let dataSet = LineChartDataSet(entries: entries, label: "3 days ")
        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.fillAlpha = 0.42
        dataSet.lineWidth = 1
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        if let price = viewModel.priceChange, price >= 0.0 {
            dataSet.setColors(.systemGreen)
        } else {
            dataSet.setColors(.red)
        }

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

