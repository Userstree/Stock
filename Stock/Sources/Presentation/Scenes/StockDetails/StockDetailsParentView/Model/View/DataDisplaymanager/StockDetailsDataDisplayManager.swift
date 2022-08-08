//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


fileprivate typealias PagingViewControllerProtocols = PagingViewControllerDataSource & PagingViewControllerSizeDelegate

final class StockDetailsDataDisplayManager: NSObject, PagingViewControllerProtocols {
    // MARK: - Properties
    var viewControllers = [UIViewController]()
    var viewControllersTitles = [String]()


    // MARK: - PagingViewControllerDataSource Protocol
    public func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        viewControllers.count
    }

    public func pagingViewController(_ controller: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let viewController = viewControllers[index]
        return viewController
    }

    public func pagingViewController(_ controller: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        PagingIndexItem(index: index, title: viewControllersTitles[index])
    }


    // MARK: - PagingViewControllerSizeDelegate Protocol
    @MainActor func pagingViewController(_ pagingViewController: PagingViewController, widthForPagingItem pagingItem: PagingItem, isSelected: Bool) -> CGFloat {
        guard let item = pagingItem as? PagingIndexItem else {
            return 0
        }

        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: pagingViewController.options.menuItemSize.height)
        let attributes = [
            NSAttributedString.Key.font: pagingViewController.options.font
        ]

        let rect = item.title.boundingRect(with: size,
                options: .usesLineFragmentOrigin,
                attributes: attributes,
                context: nil)

        let width = ceil(rect.width) + insets.left + insets.right

        if isSelected {
            return width * 1.75
        } else {
            return width * 1.4
        }
    }

}