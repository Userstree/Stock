//
// Created by Dossymkhan Zhulamanov on 02.08.2022.
//

extension UIImageView {

    @discardableResult
    func backgroundColor(_ value: UIColor) -> Self {
        backgroundColor = value

        return self
    }

    @discardableResult
    func tintColor(_ value: UIColor) -> Self {
        tintColor = value

        return self
    }

    @discardableResult
    func contentMode(_ value: UIView.ContentMode) -> Self {
        contentMode = value

        return self
    }

    @discardableResult
    func isSkeletonable(_ value: Bool) -> Self {
        isSkeletonable = value

        return self
    }

    @discardableResult
    func isUserInteractionEnabled(_ value: Bool) -> Self {
        isUserInteractionEnabled = value

        return self
    }
}