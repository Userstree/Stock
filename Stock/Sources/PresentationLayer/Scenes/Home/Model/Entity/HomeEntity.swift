//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//

let entityNotificationKey = "entity"

protocol HomeEntity {
    // MARK: - Properties
    var allStocksList: [SingleStockViewModel] { get set }
    var favoritesStocksList: [SingleStockViewModel] { get set }

    // MARK: - Methods
    func appendToFavoriteStocksList(_ value: SingleStockViewModel, position: Int)
    func removeFromFavoriteStocksList(_ value: SingleStockViewModel, position: Int)

}

class HomeEntityImpl: HomeEntity {

    // MARK: - HomeEntity Protocol
    var allStocksList = [SingleStockViewModel]()
    var favoritesStocksList = [SingleStockViewModel]()


    // MARK: - Methods
    func appendToFavoriteStocksList(_ value: SingleStockViewModel, position: Int) {
        guard !favoritesStocksList.contains(value) else {
            return
        }
        var stock = value
        stock.isLiked = true
        allStocksList.remove(at: position)
        allStocksList.insert(stock, at: position)
        favoritesStocksList.append(stock)
        NotificationCenter.default.post(name: Notification.Name(entityNotificationKey), object: nil)
    }

    func removeFromFavoriteStocksList(_ value: SingleStockViewModel, position: Int) {
        guard favoritesStocksList.contains(value) else {
            return
        }
        var stock = value
        stock.isLiked = false
        allStocksList[position].isLiked = false
        favoritesStocksList.remove(at: position)
        NotificationCenter.default.post(name: Notification.Name(entityNotificationKey), object: nil)
    }


    // MARK: - Init
    init() {

    }
}