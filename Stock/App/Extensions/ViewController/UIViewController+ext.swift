//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//

fileprivate var activityView: UIView?

extension UIViewController {
    func showSpinner() {
        activityView = UIView(frame: view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        view.addSubview(activityView!)
    }

    func hideSpinner() {
        activityView?.isHidden = true
    }
}
