//
// Created by Dossymkhan Zhulamanov on 21.07.2022.
//


class CollectionView<Item, Cell: UICollectionViewCell>: UICollectionViewController {
    // MARK: - Vars & Lets
    var items: [Item] = []
    let configure: (Cell, Item) -> Void
    var didSelect: (Item) -> () = { _ in }

    // MARK: - CollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
        let item = items[indexPath.item]
        configure(cell, item)
        return cell
    }

    // MARK: - CollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        didSelect(item)
    }

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(Cell.self, forCellWithReuseIdentifier: String(describing: Cell.self))
    }

    // MARK: - Init
    init(collectionViewLayout layout: UICollectionViewLayout,
         items: [Item],
         configure: @escaping (Cell, Item) -> Void) {
        self.configure = configure
        super.init(collectionViewLayout: layout)
        self.items = items
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
