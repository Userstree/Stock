//
// Created by Dossymkhan Zhulamanov on 26.07.2022.
//


actor DataRepository {

    let remoteAPi = RemoteAPIRequest()

    // MARK: - Remote Repository
    @MainActor func getAll() async {
            do {
                try await remoteAPi.getAllStocksList()
            } catch {
                "Could not execute the detached task"
            }
    }

}
