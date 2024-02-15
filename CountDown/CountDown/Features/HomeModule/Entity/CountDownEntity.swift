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
            Self(title: "Movie night", eventDate: Date() + 14400, creationDate: Date() - 7200, state: .counting),
            Self(title: "Journey to Italy!🇮🇹", eventDate: Date() + 864_100, creationDate: Date() - 172_800, state: .happend),
            Self(title: "Documents closing time", eventDate: Date() + 9, creationDate: Date() - 20, state: .happend)
        ]

        completion(countDowns)
    }
}
