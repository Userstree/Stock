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
        let viewController = StockDetailsParentAssembly.assemble(for: viewModel)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(viewController, animated: true)
        }
    }

}
