//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class ChartInteractor: ChartInteractorInputType {
    // MARK: - Dependencies
    var remoteDataRepository: RemoteDataRepositoryType?


    // MARK: - ChartInteractorInputType Protocol Properties
    weak var interactorOutput: ChartInteractorOutputType!
    var chartEntity: ChartEntityType?


    // MARK: - ChartInteractorInputType Protocol Methods
    func fetchRemoteStockData(title: String, resolution: String) {

    }

    // MARK: - Init
    init() {
    }

}