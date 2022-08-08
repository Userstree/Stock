//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


final class CompanyCatogyCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    let titleLabel = UILabel()
            .font(ofSize: 16, weight: .regular)


    // MARK: - Lifecycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }

    // MARK: - Configuration of the Views
    private func configureViews() {
        [
            titleLabel
        ].forEach(contentView.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }
}