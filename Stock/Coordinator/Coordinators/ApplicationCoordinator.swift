//
// Created by Dossymkhan Zhulamanov on 23.07.2022.
//


final class ApplicationCoordinator: BaseCoordinator {

    // MARK: - Vars & Lets
    private var coordinatorFactory: CoordinatorFactoryProtocol
    private var viewControllerFactory: ViewControllerFactory = ViewControllerFactory()
    private var router: RouterProtocol

    override func start() {
        super.start()
        runHomeFlow()
    }

    private func runHomeFlow() {
        let coordinator = coordinatorFactory.makeHomeCoordinatorBox(router: router,
                coordinatorFactory: coordinatorFactory,
                viewControllerFactory: viewControllerFactory
        )
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    // MARK: - Init

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.coordinatorFactory = coordinatorFactory
        self.router = router
        super.init()
    }
}