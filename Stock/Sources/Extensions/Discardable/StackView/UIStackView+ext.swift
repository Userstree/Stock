//
// Created by Dossymkhan Zhulamanov on 21.07.2022.
//


extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis = .vertical,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill
    ) {
        self.init(frame: .zero)
        self.distribution = distribution
        self.axis = axis
        self.alignment = alignment
    }
}

extension UIStackView {
    @discardableResult
    func spacing(_ value: Int) -> Self {
        self.spacing = CGFloat(value)

        return self
    }

    @discardableResult
    func distribution(_ value: UIStackView.Distribution) -> Self {
        self.distribution = value

        return self
    }

    @discardableResult
    func alignment(_ value: UIStackView.Alignment) -> Self {
        alignment = value

        return self
    }

    @discardableResult
    func axis(_ value: NSLayoutConstraint.Axis) -> Self {
        self.axis = value

        return self
    }

}
