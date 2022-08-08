//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//

final class SummaryIneractor: SummaryInteractorInputType {
    // MARK: - SummaryInteractorInputType Protocol Properties
    weak var interactorOutput: SummaryInteractorOutputType?
    var summaryEntity: SummaryEntityType?
    var remoteDataRepository: RemoteDataRepositoryType?

    // MARK: - SummaryInteractorInputType Protocol Methods
    func fetchRemoteSummary(for symbol: String) {
//        remoteDataRepository.
    }

}