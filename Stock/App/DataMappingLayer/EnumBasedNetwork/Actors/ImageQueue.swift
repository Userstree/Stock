//
// Created by Dossymkhan Zhulamanov on 03.08.2022.
//


actor ImageQueue {
    var pending: Set<URL> = []
    var finished: [URL: String] = [:]

    public func enqueue(_ url: URL) {
        guard finished[url] == nil { else return }
        pending.insert(url)
    }

    public func
}

