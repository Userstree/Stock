//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//

import Foundation

final class SearchHistoryCollectionDisplayManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties
    lazy var searchHistoryData = [String]()


    // MARK: - Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchHistoryData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchCollectionCell.self), for: indexPath) as! SearchCollectionCell
        cell.titleLabel.text = searchHistoryData[indexPath.item]
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        return cell
    }
}