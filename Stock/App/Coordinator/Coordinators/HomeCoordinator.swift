//
// Created by Dossymkhan Zhulamanov on 23.07.2022.
//


class HomeCoordinator: BaseCoordinator {

    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

    // MARK: - Private methods

    private func showHomeViewController() {
        let homeViewController = viewControllerFactory.instantiateHomeViewController()
        router.setRootModule(homeViewController, hideBar: false)
    }

    private func showBViewController() {
    }

    private func showProfile() {
    }

    // MARK: - Coordinator

    override func start() {
        showHomeViewController()
    }

    // MARK: - Init

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }

}