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
        static var timerIcon = UIImage(systemName: "timer")?
            .withRenderingMode(.alwaysTemplate)
    }
}
