//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class ChartInteractor: ChartInteractorInputType {
    // MARK: - Dependencies
    var remoteDataRepository: RemoteDataRepositoryType?


    // MARK: - ChartInteractorInputType Protocol Properties
    weak var interactorOutput: ChartInteractorOutputType!
    var chartEntity: ChartEntityType?
    var summaryEntity: SummaryEntity?


    // MARK: - ChartInteractorInputType Protocol Methods
    func fetchRemoteStockData(title: String, resolution: String) {

    }

    func loadRemoteSummary(for symbol: String) {
        remoteDataRepository?.loadSummary(for: symbol)
        remoteDataRepository?.companySummaryCallBack = { [unowned self] summary in
            self.interactorOutput?.didPrepareSummaryEntity(summary)
        }
    }

    // MARK: - Init
    init() {
    }

}