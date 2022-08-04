//
// Created by Dossymkhan Zhulamanov on 29.07.2022.
//


protocol StockDetailsModellable: Decodable {
    var title: String { get set }
    var subTitle: String { get set }
}

//protocol RemoteDataViewModellable {
//    typealias T
//    var container: []
//}