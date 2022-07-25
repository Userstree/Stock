//: A UIKit based Playground for presenting user interface

import RxSwift
import Stock
import UIKit
import PlaygroundSupport


extension URLSession {
    func load<A>(url: URL, parse: )
}
//enum StockRepo {
//    case value:
//}

//struct MarketCellInfo {
//    var title: String
//    var subTitle: String
//    var value: Int
//    var valueDifference: Int
//}

//let items = [MarketCellInfo(title: "DOW", subTitle: "Dow Jones", value: 32314, valueDifference: 132),
//             MarketCellInfo(title: "S&P 500", subTitle: "The Standard and Poor's 500", value: 12312, valueDifference: 12),
//]
//
//class MyViewController: UIViewController {
//
//    // MARK: - Vars & Lets
//    private lazy var marketIndexesCollection: UICollectionView = {
//        let flow = UICollectionViewFlowLayout()
//        flow.scrollDirection = .horizontal
//
//        let collection = CollectionView(collectionViewLayout: flow, items: items) { (cell: MarketIndexCell, item) in
//            cell.title.text = item.title
//            cell.subTitle.text = item.subTitle
//            cell.value.text = "\(item.value)"
//            cell.valueDiffPercent.text = "\(item.valueDifference)"
//        }
//        return collection.collectionView
//    }()
//
//    // MARK: - Controller lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//}
//
//public class MarketIndexCell: UICollectionViewCell {
//
//    // MARK: - Vars & Lets
//
//    var title = UILabel()
//            .font(ofSize: 18, weight: .semibold)
//
//    var subTitle = UILabel()
//            .font(ofSize: 14, weight: .regular)
//
//    var iconImage = UIImageView()
//
//    var chartImage = UIImageView()
//
//    var value = UILabel()
//            .font(ofSize: 16, weight: .regular)
//
//    var valueDiffPercent = UILabel()
//            .font(ofSize: 14, weight: .regular)
//
//    private lazy var upperHStack = UIStackView(axis: .horizontal)
//
//    private lazy var titlesVStack = UIStackView(axis: .vertical)
//
//    private lazy var valuesVStack = UIStackView(axis: .vertical)
//
//    private lazy var leftSideVStack = UIStackView(axis: .vertical)
//
//    private lazy var mainHStack = UIStackView(axis: .horizontal)
//
//    // MARK: - Controller lifecycle
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        configureViews()
//    }
//
//    // MARK: - Configuring the Views
//
//    private func configureViews() {
//        [title, subTitle].forEach(titlesVStack.addArrangedSubview)
//        makeConstraints()
//    }
//
//    private func makeConstraints() {
//
//    }
//
//    // MARK: - Init
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
