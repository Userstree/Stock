//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


final class StockDetailsParentViewController: UIViewController, StockDetailsViewType {
    // MARK: - StockDetailsViewType Protocol Properties
    var viewOutput: StockDetailsPresenterType!


    // MARK: - StockDetailsViewType Protocol Methods
    func didPrepareViewControllers(_ value: [UIViewController], titles: [String]) {
        dataDisplayManager?.viewControllersTitles = titles
        dataDisplayManager?.viewControllers = value
    }

    // MARK: - Properties
    var dataDisplayManager: StockDetailsDataDisplayManager?

    private lazy var isStarSelected: Bool = false {
        didSet {
            if isStarSelected {
                starButton.setImage(UIImage(systemName: "star.fill")!)
            } else {
                starButton.setImage(UIImage(systemName: "star")!)
            }
        }
    }

    private lazy var starButton = UIButton()
            .setImage(UIImage(systemName: "star")!)
            .tintColor(.systemYellow)
            .target(target: self, action: #selector(didTapStarItem), for: .touchUpInside)

    private lazy var navTitleLabel = UILabel()
            .text("Not Title\n Not available")
            .textAlignment(.center)
            .numberOfLines(2)
            .font(ofSize: 16, weight: .semibold)
            .textColor(R.color.text()!)

    private lazy var pagingViewController: PagingViewController = {
        let pagingViewController = PagingViewController(viewControllers: dataDisplayManager!.viewControllers)
        pagingViewController.dataSource = dataDisplayManager
        pagingViewController.sizeDelegate = dataDisplayManager

        pagingViewController.selectedBackgroundColor = .white
        pagingViewController.selectedTextColor = R.color.text()!
        pagingViewController.indicatorColor = R.color.cellHeaderBackground()!
        pagingViewController.textColor = R.color.cellTitleLabelColor()!
        pagingViewController.backgroundColor = R.color.backgroundColor()!
        pagingViewController.menuBackgroundColor = .clear

        return pagingViewController
    }()


    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput.onViewDidLoad()
        configureViews()
        configureNavigationItems()
        view.backgroundColor = R.color.backgroundColor()
    }


    // MARK: - Navigation Bar Configuration
    private func configureNavigationItems() {
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        navigationItem.backBarButtonItem
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        navigationItem.titleView = navTitleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: starButton)
    }


    // MARK: - Actions
    @objc private func didTapStarItem() {
        print("star tapped ")
        isStarSelected = !isStarSelected
    }


    // MARK: - Configuration of the Views
    private func configureViews() {
        add(pagingViewController)
        view.addSubview(pagingViewController.view)
        makeConstraints()
    }

    private func makeConstraints() {
        pagingViewController.view.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }

}
