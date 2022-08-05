//
// Created by Dossymkhan Zhulamanov on 05.08.2022.
//

protocol FaforiteStockViewModelProvidable {
    init(with managedObjectContext: NSManagedObjectContext, fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate)
    var fetchedResultsController: NSFetchedResultsController<FavoriteStockViewModel> { get set }
    var managedObjectContext: NSManagedObjectContext { get set }
}

class FavoriteStockViewModelProvider: FaforiteStockViewModelProvidable {
    // MARK: - Properties, aka Vars & Lets
    var managedObjectContext: NSManagedObjectContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    private weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?

    lazy var fetchedResultsController: NSFetchedResultsController<FavoriteStockViewModel> = {
        let fetchRequest: NSFetchRequest<FavoriteStockViewModel> = FavoriteStockViewModel.createFetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(FavoriteStockViewModel.title), ascending: false)]
        let controller = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: managedObjectContext,
                sectionNameKeyPath: nil,
                cacheName: nil
        )
        controller.delegate = fetchedResultsControllerDelegate

        do {
            try controller.performFetch()
        } catch {
            print("Failed to fetch")
        }
        return controller
    }()

    // MARK: - Methods
    func delete() {
        print("in delete of provider")
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            switch type {
            case .delete:
                print("eraerg")
            default:
                break
            }
        }
    }

    // MARK: - Init
    required init(with managedObjectContext: NSManagedObjectContext, fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate) {

    }
}
