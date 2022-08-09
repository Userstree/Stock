//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultViewControllerDidSelect(searchResult: SearchResult)

}


final class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    weak var delegate: SearchResultViewControllerDelegate?


    private var results: [SearchResult] = []

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self,
                forCellReuseIdentifier: String(describing: SearchTableViewCell.self))
        table.isHidden = true
        return table
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViews()
    }

    // MARK: - Configuration of the Views
    private func configureViews() {
        [
            tableView,
        ].forEach(view.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    public func update(with result: [SearchResult]){
        self.results = result
        tableView.isHidden = result.isEmpty
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource Protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchTableViewCell.self),
                for: indexPath) as! SearchTableViewCell


        let model = results[indexPath.row]

        cell.title.text = model.symbol
//        error here work on it!!
        cell.subTitle.text = model.exchange
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = results[indexPath.row]
        delegate?.searchResultViewControllerDidSelect(searchResult: model)
    }

}