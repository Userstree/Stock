//
// Created by Dossymkhan Zhulamanov on 21.07.2022.
//


open class CollectionView<Item, Cell: UICollectionViewCell>: UICollectionViewController {
    // MARK: - Vars & Lets
    var items: [Item] = []
    let configure: (Cell, Item) -> Void
    var didSelect: (Item) -> () = { _ in }

    // MARK: - CollectionViewDataSource
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
        let item = items[indexPath.item]
        configure(cell, item)
        return cell
    }

    // MARK: - CollectionViewDelegate
    open override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        didSelect(item)
    }

    // MARK: - Controller lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(Cell.self, forCellWithReuseIdentifier: String(describing: Cell.self))
    }

    // MARK: - Init
    public init(collectionViewLayout layout: UICollectionViewLayout,
         items: [Item],
         configure: @escaping (Cell, Item) -> Void) {
        self.configure = configure
        super.init(collectionViewLayout: layout)
        self.items = items
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
