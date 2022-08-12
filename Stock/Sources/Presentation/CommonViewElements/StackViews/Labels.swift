//
// Created by Dossymkhan Zhulamanov on 12.08.2022.
//


extension UIStackView {
    convenience init(elements: [ContentElement]) {
        self.init()
        elements.forEach { addArrangedSubview( $0.view ) }
    }
}

enum ContentElement {
    case largeTitle(String)
    case smallTitle(String)
}

extension ContentElement {
    var view: UIView {
        switch self {
        case .largeTitle(let textString):
            return UILabel().font(ofSize: 24, weight: .semibold).text(textString)
        case .smallTitle(let textString):
            return UILabel().font(ofSize: 18, weight: .regular).text(textString)
        }
    }
}
