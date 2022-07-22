//
// Created by Dossymkhan Zhulamanov on 22.07.2022.
//

class TableView<Item, Cell: UITableViewCell>: UITableViewController {
    // MARK: - Vars & Lets
    var items: [Item] = []
    var didSelect: (Item) -> Void
    var configure: (Item, Cell) -> Void

    // MARK: - TableViewDelegate

    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String##Swift.String#>, for: <#T##IndexPath##Foundation.IndexPath#>)
    }

    // MARK: - Controller lifecycle

    // MARK: - Init
    init(style: UITableView.Style? = .plain,
         items: [Item],
         configure: @escaping (Item, Cell) -> ()
    ) {
        self.items = items
        self.didSelect = didSelect
        self.configure = configure
        super.init(style: style!)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
