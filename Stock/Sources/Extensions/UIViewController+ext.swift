//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


@nonobjc extension UIViewController: UITextFieldDelegate {

    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    func addRelativeTo(someView: UIView, offsetTop: Int = 0, offsetBottom: Int = 0, _ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)

        child.view.snp.makeConstraints {
            $0.top.equalTo(someView.snp.bottom).offset(offsetTop)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom).offset(-offsetBottom)
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}