//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//

struct ButtonViewModel {
    var timeValue: Int
}

final class ButtonsCollectionDataManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var buttonsViewModels = [ButtonViewModel]()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        buttonsViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeButtonCollectionCell.self), for: indexPath) as! TimeButtonCollectionCell
        cell.timeLabel.text = "\(buttonsViewModels[indexPath.section].timeValue)"
        return cell
    }
}