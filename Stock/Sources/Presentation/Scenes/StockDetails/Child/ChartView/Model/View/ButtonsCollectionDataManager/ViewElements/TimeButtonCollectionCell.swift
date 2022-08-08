//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class TimeButtonCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    var currentSelected: Int = 0

    lazy var timeLabel = UILabel()
            .font(ofSize: 16, weight: .semibold)
            .textColor(.white)
            .textAlignment(.center)


    // MARK: - Lifecycle Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
        contentView.backgroundColor = R.color.button()!
        contentView.backgroundColor = isSelected ? UIColor.systemGray3 : R.color.button()!
        contentView.clipsToBounds = true
    }

    func configure(with viewModel: ButtonViewModel) {
        timeLabel.text = viewModel.timeValue
    }

    override var isSelected: Bool {
        get {
            super.isSelected
        }
        set {
            super.isSelected = (currentSelected != 0)
        }
    }

    // MARK: - Configuration of the Views

    private func configureViews() {
        contentView.addSubview(timeLabel)
        makeConstraints()
    }

    private func makeConstraints() {
        timeLabel.snp.makeConstraints {
            $0.center.equalTo(contentView.snp.center)
        }
    }

}