//
// Created by Dossymkhan Zhulamanov on 28.07.2022.
//


protocol NetworkingService {
    @discardableResult
    func searchStocks<A: Decodable>(withQuery query: String, completion: @escaping ([A]) -> ()) -> URLSessionDataTask
}

final
class NetworkingApi: NetworkingService {
    private let session = URLSession.shared

    @discardableResult
    func searchStocks<A: Decodable>(withQuery query: String, completion: @escaping ([A]) -> ()) -> URLSessionDataTask {
        let request = URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=\(query)")!)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode(SearchResponse<A>.self, from: data) else {
                    completion([])
                    return
                }
                completion(response.items)
            }
        }
        task.resume()
        return task
    }
}

fileprivate
struct SearchResponse<A>: Decodable {
    let items: [A]
}
