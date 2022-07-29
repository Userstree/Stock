//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//


protocol NetworkingService {
    @discardableResult
    func getAllStocksList<A: Decodable>(completion: @escaping ([A]) -> ()) -> URLSessionDataTask
    @discardableResult
    func searchStocks<A: Decodable>(with query: String, completion: @escaping ([A]) -> ()) -> URLSessionDataTask
}

final
class NetworkingApi: NetworkingService {
    private let session = URLSession.shared

    @discardableResult
    func searchStocks<A: Decodable>(with query: String, completion: @escaping ([A]) -> ()) -> URLSessionDataTask {
        var finhubAPI = "https://finnhub.io/api/v1/search?q="
        if !query.isEmpty {
            finhubAPI.append(query)
            finhubAPI.append("&token=cbhd3eaad3i0blffqelg")
        } else {
            finhubAPI.append("&token=cbhd3eaad3i0blffqelg")
        }
        let request = URLRequest(url: URL(string: finhubAPI)!)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode(SearchedStocks<A>.self, from: data)
                else {
                    completion([])
                    return
                }
                completion(response.result)
            }
        }
        task.resume()
        return task
    }

    @discardableResult
    func getAllStocksList<A: Decodable>(completion: @escaping ([A]) -> ()) -> URLSessionDataTask {
        var stocksAPI = "https://finnhub.io/api/v1/stock/symbol?exchange=US&token=cbhd3eaad3i0blffqelg"
        let request = URLRequest(url: URL(string: stocksAPI)!)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode([A].self, from: data)
                else {
                    fatalError("nil instead of response from API")
                    completion([])
                    return
                }
                completion(response)
            }
        }
        task.resume()
        return task
    }
}

fileprivate
struct SearchResponse<A: Decodable>: Decodable {
    let items: [A]
}


fileprivate
struct SearchedStocks<A: Decodable>: Decodable {
    var count: Int
    var result: [A]
}
