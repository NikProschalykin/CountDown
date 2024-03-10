import Foundation

enum TimeOfDay {
    case day
    case night
}

final class DateService {
    func getDisplayedString(from eventDate: Date) -> String {
        let duration = Int(Double(eventDate - Date.now).rounded())

        guard duration >= 0 else { return String(localized: "event_happend") }

        let seconds = duration % 60
        let minutes = (duration / 60) % 60
        let hours = duration / 3600 % 24
        let days = (duration / 3600) / 24

        let secondsStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let minutesStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let hoursStr = hours < 10 ? "0\(hours)" : "\(hours)"
        let daysStr = days < 10 ? "0\(days)" : "\(days)"

        return days == 0 ? [hoursStr, minutesStr, secondsStr].joined(separator: ":") : [daysStr, hoursStr, minutesStr, secondsStr].joined(separator: ":")
    }

    func getProgressValue(creationDate: Date, eventDate: Date) -> Double {
        let currentInterval = Date.now.timeIntervalSinceReferenceDate
        let startInterval = creationDate.timeIntervalSinceReferenceDate
        let endInterval = eventDate.timeIntervalSinceReferenceDate

        return ((currentInterval - startInterval) / (endInterval - startInterval))
    }

    func currentTimeOfDay() -> TimeOfDay {
        let hour = Calendar(identifier: .gregorian).component(.hour, from: Date())
        switch hour {
        case 0..<8:
            return .night
        case 8..<20:
            return .day
        case 20...24:
            return .night
        default:
            return .day
        }
    }

    func getCurrentMonthFullString() -> String {
        let month = Calendar(identifier: .gregorian).component(.month, from: Date())

        switch month {
        case 1:
            return String(localized: "January")
        case 2:
            return String(localized: "February")
        case 3:
            return String(localized: "March")
        case 4:
            return String(localized: "April")
        case 5:
            return String(localized: "May")
        case 6:
            return String(localized: "June")
        case 7:
            return String(localized: "July")
        case 8:
            return String(localized: "August")
        case 9:
            return String(localized: "September")
        case 10:
            return String(localized: "October")
        case 11:
            return String(localized: "November")
        case 12:
            return String(localized: "December")
        default:
            return ""
        }
    }

    func getCurrentDayString() -> String {
        String(Calendar(identifier: .gregorian).component(.day, from: Date()))
    }
}
