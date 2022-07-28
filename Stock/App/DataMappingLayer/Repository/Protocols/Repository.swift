//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//

import RxSwift
import RxCocoa

protocol Repository {
    associatedtype T

    func getAll() -> Observable<[T]>
    func get(objectWith symbol: String) -> Observable<T>
}
