//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//

struct ButtonViewModel {
    var timeValue: String
}

final class ButtonsCollectionDataManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties
    var onButtonTapped: ((String) -> Void)?
    var currentSelected: Int = 0

    var buttonsViewModels: [ButtonViewModel] = [
        ButtonViewModel(timeValue: "15"),
        ButtonViewModel(timeValue: "30"),
        ButtonViewModel(timeValue: "D"),
        ButtonViewModel(timeValue: "W"),
        ButtonViewModel(timeValue: "M"),
    ]


    // MARK: - UICollectionViewDataSource Protocol

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        buttonsViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeButtonCollectionCell.self), for: indexPath) as! TimeButtonCollectionCell
//        cell.contentView.backgroundColor = indexPath.item == currentSelected ? UIColor.systemGray5 : R.color.button()!
        cell.isSelected
        cell.configure(with: buttonsViewModels[indexPath.item])
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        return cell
    }

    // MARK: - UICollectionViewDelegate Protocol

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onButtonTapped?(buttonsViewModels[indexPath.item].timeValue)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 32, height: 32)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        45
    }

    // MARK: - Init

    override init() {
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)")
    }

}