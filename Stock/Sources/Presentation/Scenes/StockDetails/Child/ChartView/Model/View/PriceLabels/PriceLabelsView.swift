//
// Created by Dossymkhan Zhulamanov on 13.08.2022.
//

class PriceLabelsView: UIView {
    // MARK: - Properties
    var industryLabel = UILabel()
            .text("Industry...")
            .font(ofSize: 16, weight: .regular)
            .textColor(.black)

    var priceLabel = UILabel()
            .font(ofSize: 28, weight: .semibold)

    var changeIndicatorImageView = UIImageView()

    var priceChangeLabel = UILabel()
            .font(ofSize: 14, weight: .regular)
            .cornerRadius(8)
            .clipsToBounds(true)
            .textAlignment(.center)

    lazy var mainVStackView = UIStackView()
            .axis(.vertical)
            .spacing(16)
            .alignment(.leading)

    lazy var bottomHStackView = UIStackView()
            .axis(.horizontal)
            .spacing(4)
            .alignment(.firstBaseline)


    // MARK: - Lifecycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        mainVStackView.frame = self.bounds
        mainVStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight, ]
        addSubview(mainVStackView)
        industryLabel.layer.borderWidth = 1
    }

    private func configureSubViews() {
        [priceLabel, changeIndicatorImageView, priceChangeLabel].forEach { bottomHStackView.addArrangedSubview($0) }
        [industryLabel, bottomHStackView].forEach { mainVStackView.addArrangedSubview($0) }
    }


    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("we do not use XIBs")
    }

}
