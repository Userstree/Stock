//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//


protocol Repository {
    associatedtype T

    func create() -> T
    func getAll() -> [T]?
    func get(objectWith id: String) -> T?
    func update(objectWith id: String)
    func delete(objectWith id: String)
}