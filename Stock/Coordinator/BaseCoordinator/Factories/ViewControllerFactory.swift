//
// Created by Dossymkhan Zhulamanov on 23.07.2022.
//


final class ViewControllerFactory {
    func instantiateHomeViewController() -> HomeViewController {
        let viewController = HomeViewController()
        let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = HomeRouter()
        viewController.presenter?.interactor = HomeInteractor()
        return viewController
    }
}