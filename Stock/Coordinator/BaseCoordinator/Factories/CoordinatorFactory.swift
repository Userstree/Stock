//
// Created by Dossymkhan Zhulamanov on 23.07.2022.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeHomeCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> HomeCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {

    // MARK: - CoordinatorFactoryProtocol
    func makeHomeCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> HomeCoordinator {
        HomeCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
    }

}
