//
// Created by Dossymkhan Zhulamanov on 24.07.2022.
//


public class MarketIndexCell: UICollectionViewCell {

    // MARK: - Vars & Lets

    var title = UILabel()
            .font(ofSize: 18, weight: .semibold)

    var subTitle = UILabel()
            .font(ofSize: 14, weight: .regular)

    var iconImage = UIImageView()

    var chartImage = UIImageView()

    var value = UILabel()
            .font(ofSize: 16, weight: .regular)

    var valueDiffPercent = UILabel()
            .font(ofSize: 14, weight: .regular)

    // MARK: - StackViews

    private lazy var upperHStack = UIStackView(axis: .horizontal)

    private lazy var titlesVStack = UIStackView(axis: .vertical)

    private lazy var valuesVStack = UIStackView(axis: .vertical)

    private lazy var leftSideVStack = UIStackView(axis: .vertical)

    private lazy var mainHStack = UIStackView(axis: .horizontal)

    // MARK: - Controller lifecycle

    public override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }

    // MARK: - Configuring the Views

    private func configureViews() {
        [title, subTitle].forEach(titlesVStack.addArrangedSubview)
        makeConstraints()
    }

    private func makeConstraints() {

    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
