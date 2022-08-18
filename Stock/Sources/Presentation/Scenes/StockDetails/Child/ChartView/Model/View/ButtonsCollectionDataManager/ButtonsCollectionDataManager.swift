//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//

enum ButtonViewModel: String {
    case fifteenMinutes = "15"
    case thirtyMinutes = "30"
    case day = "D"
    case week = "W"
    case month = "M"
}

final class ButtonsCollectionDataManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties
    var onButtonTapped: ((ButtonViewModel) -> Void)?

    var buttonsVMs: [ButtonViewModel] = [
        ButtonViewModel.fifteenMinutes,
        ButtonViewModel.thirtyMinutes,
        ButtonViewModel.day,
        ButtonViewModel.week,
        ButtonViewModel.month,
    ]


    // MARK: - UICollectionViewDataSource Protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        buttonsVMs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeButtonCollectionCell.self), for: indexPath) as! TimeButtonCollectionCell
        cell.configure(with: buttonsVMs[indexPath.item])
        return cell
    }

    // MARK: - UICollectionViewDelegate Protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeButtonCollectionCell.self), for: indexPath) as! TimeButtonCollectionCell
        cell.backgroundColor = .white
        cell.timeLabel.textColor = .black
        onButtonTapped?(buttonsVMs[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeButtonCollectionCell.self), for: indexPath) as! TimeButtonCollectionCell
        cell.backgroundColor = .black
        cell.timeLabel.textColor = .white
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 32, height: 32)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        45
    }

}