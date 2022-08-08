//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


final class SearchCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    lazy var titleLabel = UILabel()
            .font(ofSize: 12, weight: .regular)
            .textColor(.black)

    // MARK: - Lifecycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }

    // MARK: - Configuration of the Views
    private func configureViews() {
        [
            titleLabel,
        ].forEach(contentView.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }
}