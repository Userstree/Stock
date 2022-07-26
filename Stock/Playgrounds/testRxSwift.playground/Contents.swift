//: A UIKit based Playground for presenting user interface

import RxSwift
import RxCocoa
import Stock
import UIKit
import Foundation
import PlaygroundSupport


struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL, parseJSON: (AnyObject) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}

public struct PostModel: Codable {
    private var id: Int
    private var userId: Int
    private var title: String
    private var body: String

    init(id: Int, userId: Int, title: String, body: String) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }

    func getId() -> Int {
        return self.id
    }

    func getUserId() -> Int {
        return self.userId
    }

    func getTitle() -> String {
        return self.title
    }

    func getBody() -> String {
        return self.body
    }
}

public class RequestObservable {
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession

    public init(config: URLSessionConfiguration) {
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }

    public func callAPI<ItemModel: Decodable>(request: URLRequest)
            -> Observable<ItemModel> {
        return Observable.create { observer in
            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                let statusCode = httpResponse.statusCode
                do {
                    let data = data ?? Data()
                    if (200...299).contains(statusCode) {
                        let object = try self.jsonDecoder.decode(ItemModel.self, from: data)
                        observer.onNext(object)
                    } else {
                        observer.onError(error!)
                    }
                } catch {
                    print("catch in call API")
                    observer.onError(error)
                }
                observer.onCompleted()
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}


fileprivate extension Encodable {
    var dictionaryValue: [String: Any?]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data,
                      options: .allowFragments) as? [String: Any]
        else {
            return nil
        }
        return dictionary
    }
}


class APIClient {
    static var shared = APIClient()
    lazy var requestObservable = RequestObservable(config: .default)

    func getRecipes() throws -> Observable<[PostModel]> {
        var request = URLRequest(url:
        URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField:
        "Content-Type")
        return requestObservable.callAPI(request: request)
    }

    func sendPost(recipeModel: PostModel) -> Observable<PostModel> {
        var request = URLRequest(url:
        URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField:
        "Content-Type")
        let payloadData = try? JSONSerialization.data(withJSONObject:
        recipeModel.dictionaryValue!, options: [])
        request.httpBody = payloadData
        return requestObservable.callAPI(request: request)
    }
}



class ViewController: UIViewController {
    var posts: [PostModel] = []
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let client = APIClient.shared
        do {
            try client.getRecipes().subscribe(
                            onNext: { result in
                                print("Do ", result)
                                self.posts = result
                                //MARK: display in UITableView
                            },
                            onError: { error in
                                print("Failed to fetch with error ", error.localizedDescription)
                            },
                            onCompleted: {
                                print("Completed event.")
                            })
                    .disposed(by: disposeBag)
        } catch {
            print("in viewcontroller")
        }
    }
}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = ViewController()
