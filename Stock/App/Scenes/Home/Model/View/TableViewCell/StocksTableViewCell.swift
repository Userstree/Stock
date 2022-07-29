//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//


class StocksTableViewCell: UITableViewCell {

    // MARK: - Star State
    private lazy var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                starImageView.image = UIImage(systemName: "star.fill")
            } else {
                starImageView.image = UIImage(systemName: "star")
            }
        }
    }

    // MARK: - Vars & Lets
    var stockImageIcon: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "no-Image")!)
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var starImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star"))
        imageView.tintColor = .systemYellow
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    var titleLabel = UILabel()
            .font(ofSize: 18, weight: .semibold)

    var subTitleLabel = UILabel()
            .font(ofSize: 11, weight: .regular)

    var priceLabel = UILabel()
            .font(ofSize: 18, weight: .semibold)
            .text("$???")

    var priceDifferenceLabel = UILabel()
            .font(ofSize: 12, weight: .regular)
            .text("???")

    // MARK: - Controller lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        starImageView.addGestureRecognizer(tapGestureRecognizer)
        configureViews()
    }

    // MARK: - Actions
    private lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(starImageTapped(_:)))

    @objc
    func starImageTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        isFavorite = !isFavorite
    }

    // MARK: - Configuration of the View
    private func configureViews() {
        [stockImageIcon,
         starImageView,
         titleLabel,
         subTitleLabel,
         priceLabel,
         priceDifferenceLabel,
        ].forEach(contentView.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        stockImageIcon.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(6)
            $0.size.equalTo(CGSize(width: 40, height: 40))
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(stockImageIcon.snp.trailing).offset(12)
            $0.top.equalTo(stockImageIcon.snp.top).offset(2)
        }
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
        starImageView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(2)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-6)
        }
        priceDifferenceLabel.snp.makeConstraints {
            $0.bottom.equalTo(subTitleLabel.snp.bottom)
            $0.trailing.equalTo(priceLabel.snp.trailing)
        }
    }
}
