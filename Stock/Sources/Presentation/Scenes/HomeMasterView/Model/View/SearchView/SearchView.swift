//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


final class SearchView: UIView {
    // MARK: - Properties
    lazy var popularRequestsData = [String]()
    lazy var searchHistoryData = [String]()

    var popularLabel = UILabel()
            .text("Popular Requests")
            .font(ofSize: 18, weight: .bold)
            .textColor(.black)

    lazy var popularRequestsCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(SearchCollectionCell.self, forCellWithReuseIdentifier: String(describing: SearchCollectionCell.self))
        return collection
    }()

    var historyLabel = UILabel()
            .text("You've searched for this: ")
            .font(ofSize: 18, weight: .bold)
            .textColor(.black)

    lazy var searchHistoryCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(SearchCollectionCell.self, forCellWithReuseIdentifier: String(describing: SearchCollectionCell.self))
        return collection
    }()

    // MARK: - Lifecycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        configureNavigationItems()
        configureViews()
    }


    // MARK: - Actions


    // MARK: - Configuration of the Views
    private func configureNavigationItems() {

    }

    private func configureViews() {
        [
            popularLabel,
            popularRequestsCollection,
            historyLabel,
            searchHistoryCollection,
        ].forEach(addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        popularLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
        popularRequestsCollection.snp.makeConstraints {
            $0.top.equalTo(popularLabel.snp.top).offset(8)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.height.equalTo(80)
        }
        historyLabel.snp.makeConstraints {
            $0.top.equalTo(popularRequestsCollection.snp.top).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
        searchHistoryCollection.snp.makeConstraints {
            $0.top.equalTo(popularLabel.snp.top).offset(8)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.height.equalTo(80)
        }
    }


    // MARK: - Init
    init() {
        super.init(frame: .zero)

    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)")
    }

}
