import Foundation

enum CountDownEntityState {
    case happend
    case counting
}

struct CountDownEntity {
    let title: String
    let eventDate: Date
    let creationDate: Date
    let state: CountDownEntityState

    static func getMockCountDowns(completion: @escaping ([Self]) -> Void) {
        let countDowns: [Self] = [
            Self(title: "День рождения!", eventDate: Date() + 7200, creationDate: Date() - 7200, state: .counting),
            Self(title: "Вручение аттеста!", eventDate: Date() + 172_800, creationDate: Date() - 172_800, state: .happend),
            Self(title: "Happy BirthDay", eventDate: Date() + 350, creationDate: Date() - 150, state: .counting),
            Self(title: "NewYork trip", eventDate: Date() + 10, creationDate: Date() - 20, state: .happend)
        ]

        completion(countDowns)
    }
}
