import UIKit

enum Resources {
    enum Colors {
        enum Backgrounds {
            static var background = UIColor.systemBackground
            static var countDownViewBackground = UIColor.systemGray4
        }

        enum Strings {
            static var title = UIColor.secondaryLabel
            static var text = UIColor.label
        }
    }

    enum Icons {
        static var timerIcon = UIImage(systemName: "timer")?.withRenderingMode(.alwaysTemplate)
        static var menuTimerIcon = UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysTemplate)
        static var addTimerIcon = UIImage(systemName: "goforward.plus")?.withRenderingMode(.alwaysTemplate)
        static var calendarIcon = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysTemplate)
        static var titleIcon = UIImage(systemName: "textformat")?.withRenderingMode(.alwaysTemplate)

        static var relocateTimerMenuIcon = UIImage(systemName: "arrow.up.and.down.and.arrow.left.and.right")?.withRenderingMode(.alwaysTemplate)
        static var editTimerMenuIcon = UIImage(systemName: "pencil")?.withRenderingMode(.alwaysTemplate)
        static var removeTimerMenuIcon = UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate)
    }
}
