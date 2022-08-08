//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


final class StockDetailsViewController: UIViewController, StockDetailsViewType {
    // MARK: - StockDetailsViewType Protocol
    var viewOutput: StockDetailsPresenterType!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.backgroundColor = R.color.backgroundColor()
        viewOutput.onViewDidLoad()
    }

    // MARK: - Configure NavigationBar Back Button
    private func configureNavBar() {
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        navigationItem.backBarButtonItem
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }

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
}