//
// Created by Dossymkhan Zhulamanov on 09.08.2022.
//


final class CategoriesCollectionDisplayManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var categories = [String]()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CompanyCatogyCollectionCell.self), for: indexPath) as! CompanyCatogyCollectionCell
        cell.titleLabel.text = categories[indexPath.item]

        return cell

    }

}