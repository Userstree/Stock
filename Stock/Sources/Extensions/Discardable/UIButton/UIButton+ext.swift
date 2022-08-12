//
// Created by Dossymkhan Zhulamanov on 05.08.2022.
//


extension UIButton {

    @discardableResult
    func contentInsets(_ value: UIEdgeInsets) -> Self {
        contentEdgeInsets = value

        return self
    }

    @discardableResult
    func isUserInteractionEnabled(_ value: Bool) -> Self {
        isUserInteractionEnabled = value

        return self
    }

    @discardableResult
    func font(ofSize: CGFloat, weight: UIFont.Weight) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: ofSize, weight: weight)

        return self
    }

    @discardableResult
    func setText(_ value: String) -> Self {
        setTitle(value, for: .normal)

        return self
    }

    @discardableResult
    func setImage(_ value: UIImage) -> Self {
        setImage(value, for: .normal)

        return self
    }

    @discardableResult
    func tintColor(_ value: UIColor) -> Self {
        tintColor = value

        return self
    }

    @discardableResult
    func isSkeletonable(_ value: Bool) -> Self {
        isSkeletonable = value

        return self
    }

    @discardableResult
    func target(target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Self {
        addTarget(target, action: action, for: controlEvents)

        return self
    }

    @discardableResult
    func tag(_ value: Int) -> Self {
        tag = value

        return self
    }

}