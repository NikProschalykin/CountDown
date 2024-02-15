import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
