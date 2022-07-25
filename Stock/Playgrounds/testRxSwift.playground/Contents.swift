//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import RxSwift

class MyViewController: UIViewController {

    // MARK: - Vars & Lets
    private lazy var marketIndexesCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let collection = CollectionView(collectionViewLayout: flow, items: ["Card1", "Card2"], configure: { (cell: MarketIndexCell, item) in
            cell.
        })
        return collection
    }()

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
