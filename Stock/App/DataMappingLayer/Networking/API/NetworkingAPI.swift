//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//


protocol NetworkingService {
    @discardableResult
    func searchStocks<A: Decodable>(withQuery query: String, completion: @escaping (A?) -> ()) -> URLSessionDataTask
}

final
class NetworkingApi: NetworkingService {
    private let session = URLSession.shared

    @discardableResult
    func searchStocks<A: Decodable>(withQuery query: String, completion: @escaping (A?) -> ()) -> URLSessionDataTask {
        var stocksAPI = "https://api.twelvedata.com/stocks"
        if !query.isEmpty {
            stocksAPI.append("?symbol=")
            stocksAPI.append(query)
        }
        print(stocksAPI)
        let request = URLRequest(url: URL(string: stocksAPI)!)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                print("the data is ", data)
                print("the type of A is ", String(describing: A.self))
                guard let data = data,
                      let response = try? JSONDecoder().decode(SearchResponse<A>.self, from: data) else {
                    completion(nil)
                    return
                }
                print("Items are ", response.items)
                completion(response.items)
            }
        }
        task.resume()
        return task
    }
}

fileprivate
struct SearchResponse<A: Decodable>: Decodable {
    let items: A
}
