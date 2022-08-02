//
// Created by Dossymkhan Zhulamanov on 22.07.2022.
//

class TableView<Item, Cell: UITableViewCell>: UITableViewController {
    // MARK: - Vars & Lets
    var items: [Item] = []
    var didSelect: (Item) -> Void = { _ in }
    var configure: (Cell, Item) -> Void

    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        didSelect(item)
    }

    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
        let item = items[indexPath.row]
        print("before")
        configure(cell, item)
        print("after")
        return cell
    }

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: String(describing: Cell.self))
    }

    // MARK: - Init
    init(
         items: [Item],
         configure: @escaping (Cell, Item) -> ()
    ) {
        self.items = items
        self.configure = configure
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
