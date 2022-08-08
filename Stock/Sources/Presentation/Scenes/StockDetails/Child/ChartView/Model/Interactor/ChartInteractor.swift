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

    func fetchRemoteSummary(for symbol: String) {
        remoteDataRepository?.companySummaryCallBack = { [weak self] companySummary in
            self?.summaryEntity?.companySummary = companySummary
            guard let summaryEntity = self?.summaryEntity else {
                print("error fetching summary")
                return
            }
            print(summaryEntity.companySummary?.finnhubIndustry)
            self?.interactorOutput?.didPrepareSummaryEntity(summaryEntity)
        }
    }

//    func


    // MARK: - Init
    init() {
    }

}