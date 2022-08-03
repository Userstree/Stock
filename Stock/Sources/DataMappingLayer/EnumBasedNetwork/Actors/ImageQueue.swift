//
// Created by Dossymkhan Zhulamanov on 03.08.2022.
//


actor ImagesQueue {
    var pending: Set<URL> = []
    var inProgress: Set<URL> = []
    var finished: [URL: UIImage] = [:]

    public func enqueue(_ url: URL) {
        guard finished[url] == nil else { return }
        pending.insert(url)
    }

    public func store(_ contents: UIImage, for url: URL) {
        finished[url] = contents
    }

    public func process(_ handler: (URL) async -> (String, UIImage)) async {
        guard let url = pending.popFirst() else { return }
        inProgress.insert(url)
        let (urlString, image) = await handler(url)
        finished[url] = image
        inProgress.remove(url)
    }

}

extension ImagesQueue {

}