//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class ChartViewController: UIViewController, ChartViewType {
    // MARK: - ChartViewType Protocol
    var viewOutput: ChartPresenterType!


    // MARK: - Properties
    var buttonsDataManager: ButtonsCollectionDataManager!

    private lazy var chart: StockChartView = {
        let chart = StockChartView()
        chart.isUserInteractionEnabled = false
        chart.clipsToBounds = true
        chart.isSkeletonable = true
        return chart
    }()

    private lazy var buttonsHolderCollection: UICollectionView = {
        let collection = UICollectionView()
        collection.register(TimeButtonCollectionCell.self,
                forCellWithReuseIdentifier: String(describing: TimeButtonCollectionCell.self))
        collection.delegate = buttonsDataManager
        collection.dataSource = buttonsDataManager
        return collection
    }()

    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy for ", for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        button.layer.cornerCurve = .continuous
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.setTitleColor(R.color.text()!, for: .normal)
//        button.setTitleColor(R.color.text()!, for: .highlighted)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureViews()
    }


    // MARK: - Actions



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
            $0.top.equalTo(view.snp.top).offset(8)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.height.equalTo(234)
        }
        buttonsHolderCollection.snp.makeConstraints {
            $0.top.equalTo(chart).offset(8)
            $0.leading.equalTo(chart.snp.leading)
            $0.trailing.equalTo(chart.snp.trailing)
            $0.height.equalTo(45)
        }
        buyButton.snp.makeConstraints {
            $0.top.equalTo(buttonsHolderCollection).offset(8)
            $0.leading.equalTo(chart.snp.leading)
            $0.trailing.equalTo(chart.snp.trailing)
            $0.height.equalTo(30)
        }
    }


    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)")
    }

}