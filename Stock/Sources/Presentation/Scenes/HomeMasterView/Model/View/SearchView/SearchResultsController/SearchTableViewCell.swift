//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//



final class SearchTableViewCell: UITableViewCell {
    // MARK: - Properties
    lazy var title = UILabel()
            .font(ofSize: 16, weight: .semibold)

    lazy var subTitle = UILabel()
            .font(ofSize: 14, weight: .regular)

    // MARK: - Lifecycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }

    // MARK: - Configuration of the Views
    private func configureViews() {
        [
            title,
            subTitle
        ].forEach(contentView.addSubview)
        makeConstraints()
    }

    private func makeConstraints() {
        title.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(4)
            $0.leading.equalTo(contentView.snp.leading).offset(4)
        }
        subTitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(4)
            $0.leading.equalTo(contentView.snp.leading).offset(4)
        }
    }


    // MARK: - Init
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}