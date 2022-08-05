//
// Created by Dossymkhan Zhulamanov on 24.07.2022.
//

import SkeletonView

extension UILabel {

    @discardableResult
    func numberOfLines(_ value: Int ) -> Self {
        numberOfLines = value

        return self
    }

    @discardableResult
    func textColor(_ value: UIColor) -> Self {
        textColor = value

        return self
    }

    @discardableResult
    func font(ofSize: CGFloat, weight: UIFont.Weight) -> Self {
        font = UIFont.systemFont(ofSize: ofSize, weight: weight)

        return self
    }

    @discardableResult
    func rotated(by value: CGFloat) -> Self {
        transform = CGAffineTransform(rotationAngle: value)

        return self
    }

    @discardableResult
    func textAlignment(_ value: NSTextAlignment) -> Self {
        textAlignment = value

        return self
    }

    @discardableResult
    func text(_ value: String) -> Self {
        text = value

        return self
    }

    @discardableResult
    func backgroundColor(_ value: UIColor) -> Self {
        backgroundColor = value

        return self
    }

    @discardableResult
    func cornerRadius(_ value: CGFloat) -> Self {
        layer.cornerRadius = value

        return self
    }

    @discardableResult
    func clipsToBounds(_ value: Bool) -> Self {
        clipsToBounds = value

        return self
    }

    @discardableResult
    func borderColor(_ value: UIColor) -> Self {
        layer.borderColor = value.cgColor

        return self
    }

    @discardableResult
    func borderWidth(_ value: CGFloat) -> Self {
        layer.borderWidth = value

        return self
    }

    @discardableResult
    func isSkeletonable(_ value: Bool) -> Self {
        isSkeletonable = value

        return self
    }
}
