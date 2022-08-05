//
// Created by Dossymkhan Zhulamanov on 05.08.2022.
//

protocol FavoriteStockViewModelProvidable {
    init(with managedObjectContext: NSManagedObjectContext, fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate)
    var fetchedResultsController: NSFetchedResultsController<FavoriteStockViewModel> { get set }
    var managedObjectContext: NSManagedObjectContext! { get set }
}

class FavoriteStocksPersistenceViewModelManager: FavoriteStockViewModelProvidable {

    // MARK: - Properties, aka Vars & Lets
    var managedObjectContext: NSManagedObjectContext!
    private weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?

    lazy var fetchedResultsController: NSFetchedResultsController<FavoriteStockViewModel> = {
        let fetchRequest: NSFetchRequest<FavoriteStockViewModel> = FavoriteStockViewModel.createFetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(FavoriteStockViewModel.title), ascending: false)]
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

    // MARK: - Init
    required init(with managedObjectContext: NSManagedObjectContext, fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate) {

    }
}
