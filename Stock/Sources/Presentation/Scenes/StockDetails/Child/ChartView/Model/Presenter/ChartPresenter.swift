//
// Created by Dossymkhan Zhulamanov on 08.08.2022.
//


final class ChartPresenter: ChartPresenterType, ChartInteractorOutputType {
    weak var view: ChartViewType?
    var interactorInput: ChartInteractorInputType!
    var router: ChartRouterType!

    func onViewDidLoad() {
    }
}