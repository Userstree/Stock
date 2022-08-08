//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class TimeButtonCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    lazy var timeLabel = UILabel()
            .font(ofSize: 16, weight: .semibold)
            .textColor(.black)
            .textAlignment(.center)


    // MARK: - Lifecycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }


    // MARK: - Configuration of the Views
    private func configureViews() {
        [
            timeLabel
        ].forEach(contentView.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        timeLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}