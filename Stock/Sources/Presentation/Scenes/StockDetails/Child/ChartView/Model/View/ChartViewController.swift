//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class ChartViewController: UIViewController {
    // MARK: - Properties
    lazy var chart: StockChartView = {
        let chart = StockChartView()
        chart.isUserInteractionEnabled = false
        chart.clipsToBounds = true
        chart.isSkeletonable = true
        return chart
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
            // put views here
        ].forEach(view.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {

    }


    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)")
    }

}