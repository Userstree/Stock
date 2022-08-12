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
        print("loadRemoteSummary")
        remoteDataRepository?.loadSummary(for: symbol)
        remoteDataRepository?.companySummaryCallBack = { [weak self] summary in
            print("load callback ")
            self?.summaryEntity?.companySummary = summary
            guard let summaryEntity = self?.summaryEntity else {
                print("error fetching summary")
                return
            }
            print(summaryEntity)
            self?.interactorOutput?.didPrepareSummaryEntity(summaryEntity)
        }
    }

    // MARK: - Init
    init() {
    }

}