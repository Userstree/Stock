//
//  HomeRouter.swift
//  Stock
//
//  Created by Dossymkhan Zhulamanov on 20.07.2022.
//  
//

@MainActor
final class HomeRouter: HomeRouterType {
    weak var view: UIViewController?

    // MARK: - HomeRouterType Protocol
    func createStockDetailsScreen(from view: HomeViewType, with viewModel: SingleStockViewModel) {
        let viewController = StockDetailsAssembly.assemble(for: viewModel)
//        viewController.title = viewModel.title
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(viewController, animated: true)
        }
//        view?.navigationController?.pushViewController(viewController, animated: true)
    }

}
