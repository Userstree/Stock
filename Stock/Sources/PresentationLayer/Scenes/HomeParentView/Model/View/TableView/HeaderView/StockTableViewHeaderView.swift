//
// Created by Dossymkhan Zhulamanov on 05.08.2022.
//


class StockTableViewHeaderView: UITableViewHeaderFooterView {

    // MARK: - Star State
    lazy var isLiked: Bool = false {
        didSet {
            if isLiked {
                starButton.setImage(UIImage(systemName: "star.fill")!)
            } else {
                starButton.setImage(UIImage(systemName: "star")!)
            }
        }
    }


    // MARK: - Properties
    private let titleLabel = UILabel()
            .textColor(R.color.cellTitleLabelColor()!)
            .font(ofSize: 18, weight: .bold)
            .isSkeletonable(true)

   private  let subTitleLabel = UILabel()
            .textColor(R.color.cellTitleLabelColor()!)
            .font(ofSize: 11, weight: .regular)
            .isSkeletonable(true)

    private let starButton = UIButton()
            .setImage(UIImage(systemName: "star")!)
            .tintColor(.systemYellow)
            .target(target: self, action: #selector(didTappedStarButton(_:)), for: .touchUpInside)
            .isSkeletonable(true)

   private  let priceLabel = UILabel()
            .textColor(.white)
            .font(ofSize: 15, weight: .bold)
            .rotated(by: 0.56)
            .isSkeletonable(true)

    private let labelImageView = UIImageView(image: UIImage(systemName: "app.badge.fill")!)
            .tintColor(R.color.cellLabelBackground()!)
            .contentMode(.scaleToFill)
            .isSkeletonable(true)


    // MARK: - Controller lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = R.color.cellHeaderBackground()
        contentView.isSkeletonable = true
        contentView.isHiddenWhenSkeletonIsActive = true
        configureViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configureViews()
    }

    // MARK: - Configuring the Views
    private func configureViews() {
        [
            titleLabel,
            subTitleLabel,
            labelImageView,
            priceLabel,
            starButton,
        ].forEach(contentView.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(8)
            $0.top.equalTo(contentView.snp.top).offset(8)
        }

        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }

        starButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top).offset(0)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
            $0.bottom.equalTo(titleLabel.snp.bottom)
            $0.width.equalTo(25)
        }

        labelImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).offset(10)
            $0.top.equalTo(contentView.snp.top).offset(-10)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-15)
            $0.width.equalTo(70)
        }

        priceLabel.snp.makeConstraints {
            $0.center.equalTo(labelImageView.snp.center)
        }
    }

    func configure(with viewModel: HeaderViewModel) {
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        priceLabel.text = viewModel.priceLabel
        if viewModel.isLiked {
            starButton.setImage(UIImage(systemName: "star.fill")!)
        } else {
            starButton.setImage(UIImage(systemName: "star")!)
        }
    }


    // MARK: - Actions
    @objc private func didTappedStarButton(_ sender: UIButton) {
        self.isLiked = !isLiked
        isLikedCallBack(isLiked)
    }

    var isLikedCallBack: (Bool) -> Void = { _ in }


    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

    }

    required init?(coder: NSCoder) {
        fatalError("super.init(coder: coder)")
    }
}

struct HeaderViewModel {
    var title: String
    var subTitle: String
    var priceLabel: String
    var isLiked: Bool
}

extension HeaderViewModel: SkeletonaableViewModel {
    private(set) static var skeletonable: Self = .init(title: "ergwngn", subTitle: "reonjn", priceLabel: "234", isLiked: false)
}