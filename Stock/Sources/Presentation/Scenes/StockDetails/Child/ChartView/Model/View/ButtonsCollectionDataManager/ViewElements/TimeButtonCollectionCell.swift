//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class TimeButtonCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    lazy var timeLabel = UILabel()
            .font(ofSize: 16, weight: .semibold)
            .textColor(.black)
            .textAlignment(.center)
            .backgroundColor(R.color.backgroundColor()!)


    // MARK: - Lifecycle Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
        contentView.backgroundColor = .gray
    }


    // MARK: - Configuration of the Views

    private func configureViews() {
        contentView.addSubview(timeLabel)
        makeConstraints()
    }

    private func makeConstraints() {
        timeLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }
}