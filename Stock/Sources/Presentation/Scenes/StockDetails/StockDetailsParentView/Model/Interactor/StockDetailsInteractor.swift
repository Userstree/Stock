//
// Created by Dossymkhan Zhulamanov on 07.08.2022.
//


final class StockDetailsInteractor: StockDetailsInteractorInputType {
    // MARK: - StockDetailsInteractorInputType Protocol
    weak var interactorOutput: StockDetailsInteractorOutputType?
    var remoteDataRepository: RemoteDataRepositoryType!

    // MARK: - Properties
    func getStocksData() {

    }

}