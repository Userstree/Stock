//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//

import RxSwift
import RxCocoa

class DataRepository<T: Codable> {

    // MARK: - Repository
    func getAll() -> [T]? {
        fatalError("getAll() has not been implemented")
    }

    func get(objectWith symbol: String) -> Observable<T> {
        NetworkManager().sendExchangesRequest()
    }
}