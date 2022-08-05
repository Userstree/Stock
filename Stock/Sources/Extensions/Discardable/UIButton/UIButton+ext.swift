//
// Created by Dossymkhan Zhulamanov on 05.08.2022.
//

import SkeletonView


extension UIButton {

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
    func target(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Self {
        addTarget(target, action: action, for: controlEvents)

        return self
    }

    @discardableResult
    func tag(_ value: Int) -> Self {
        tag = value

        return self
    }

}