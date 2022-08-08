//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//



final class HomeEntity: HomeEntityType {

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
    }

    func removeFromFavoriteStocksList(_ value: SingleStockViewModel, position: Int) {
        guard favoritesStocksList.contains(value) else {
            return
        }
        var stock = value
        stock.isLiked = false
        allStocksList[position].isLiked = false
        favoritesStocksList.remove(at: position)
    }


    // MARK: - Init
    init() {

    }
}