//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


final class StockDetailsParentViewController: UIViewController, StockDetailsViewType {
    // MARK: - StockDetailsViewType Protocol Properties
    var viewOutput: StockDetailsPresenterType!

    // MARK: - StockDetailsViewType Protocol Methods
    func didPrepareViewControllers(_ value: [UIViewController]) {
        viewControllers = value
    }

    // MARK: - Properties
    private lazy var viewControllers: [UIViewController] = []

    private let starButton = UIButton()
            .setImage(UIImage(systemName: "star")!)
            .tintColor(.systemYellow)
            .target(target: self, action: #selector(didTapStarItem), for: .touchUpInside)
            .isSkeletonable(true)

    private lazy var pagingViewController: PagingViewController = {
        let pagingViewController = PagingViewController(viewControllers: viewControllers)
        pagingViewController.dataSource = self
        pagingViewController.sizeDelegate = self

        pagingViewController.selectedBackgroundColor = .systemGray4
        pagingViewController.selectedTextColor = .black
        pagingViewController.indicatorColor = .green
        pagingViewController.textColor = R.color.primary()
        pagingViewController.backgroundColor = R.color.backgroundColor()
        pagingViewController.menuBackgroundColor = R.color.backgroundColor()

        return pagingViewController
    }()


    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput.onViewDidLoad()
        configureNavBar()
        view.backgroundColor = R.color.backgroundColor()
    }

    // MARK: - Configure NavigationBar Back Button
    private func configureNavBar() {
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        navigationItem.backBarButtonItem
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: starButton)
    }

    // MARK: - Actions
    @objc private func didTapStarItem() {
        print("star tapped ")
    }

    // MARK: - Configuration of the Views
    private func configureNavigationItems() {

    }

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