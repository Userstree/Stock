//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class TimeButtonCollectionCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .black : .systemGray6
            timeLabel.textColor = isSelected ? .white : .black
        }
    }


    // MARK: - Properties
    lazy var timeLabel = UILabel()
            .font(ofSize: 16, weight: .semibold)
            .textColor(.black)
            .textAlignment(.center)


    // MARK: - Lifecycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.backgroundColor = isSelected ? UIColor.red : R.color.button()!
        contentView.clipsToBounds = true
    }

    func configure(with viewModel: ButtonViewModel) {
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray3.cgColor
        layer.cornerRadius = 6
        clipsToBounds = true
        timeLabel.text = viewModel.rawValue
    }


    // MARK: - Configuration of the Views
    private func configureViews() {
        backgroundColor = .systemGray6
        contentView.addSubview(timeLabel)
        makeConstraints()
    }

    private func makeConstraints() {
        timeLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("We do not use XID in CollectionCell")
    }
}