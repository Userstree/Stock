//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//

struct ButtonViewModel {
    var timeValue: String
}

final class ButtonsCollectionDataManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties
    var onButtonTapped: ((String) -> Void)?

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
        cell.timeLabel.text = buttonsViewModels[indexPath.item].timeValue
        cell.backgroundColor = .systemGray6
        return cell
    }

    // MARK: - UICollectionViewDelegate Protocol

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onButtonTapped?(buttonsViewModels[indexPath.item].timeValue)
    }

    // MARK: - Init

    override init() {
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)")
    }

}