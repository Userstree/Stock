//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//


extension Date {

    static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy/MM/dd"

        return dateFormatter.string(from: Date())

    }
}