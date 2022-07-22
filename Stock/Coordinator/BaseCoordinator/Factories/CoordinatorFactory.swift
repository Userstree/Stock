//
// Created by Dossymkhan Zhulamanov on 23.07.2022.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeHomeCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> HomeCoordinator
}

class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeHomeCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> HomeCoordinator {

    }
}
