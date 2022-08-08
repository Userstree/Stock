//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class SummaryViewController: UIViewController, SummaryViewType {
    // MARK: - SummaryViewType Protocol Properties
    var viewOutput: SummaryPresenterType! = nil

    // MARK: - SummaryViewType Protocol Methods
    func didPrepareEntity(_ value: SummaryEntityType) {

    }


    // MARK: - Properties


    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutput.onViewDidLoad()

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