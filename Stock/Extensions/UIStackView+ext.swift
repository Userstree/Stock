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
    func spacing(_ spacing: Int) -> Self {
        spacing = spacing

        return self
    }

    @discardableResult
    func distribution(_ distribution: UIStackView.Distribution) -> Self {
        distribution = distribution

        return self
    }

    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> Self {
        alignment = alignment

        return self
    }


}
