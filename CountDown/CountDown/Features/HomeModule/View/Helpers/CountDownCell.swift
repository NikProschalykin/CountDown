import UIKit

final class CountDownCell: UICollectionViewCell {
    private var timer = Timer()
    private var eventDate: Date? = Date()
    private var creationDate: Date? = Date()
    private var progressShape = CAShapeLayer()
    private var progressFromValue = 0.0

    private lazy var countDownLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 24)
        $0.textColor = Resources.Colors.Strings.text
        
        return $0
    }(UILabel())

    private lazy var countDownTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = Resources.Colors.Strings.title

        return $0
    }(UILabel())

    private lazy var timeIcon: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "timer")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .gray

        return $0
    }(UIImageView())

    private lazy var countDownActivity: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.hidesWhenStopped = true
        $0.color = .white
        //$0.sizeToFit()

        return $0
    }(UIActivityIndicatorView(frame: .zero))

    private lazy var countDownView: UIView = {
        let view = UIView(frame: .zero)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.Colors.Backgrounds.countDownViewBackground
        view.layer.cornerRadius = 20

        let countDownLabel = countDownLabel
        view.addSubview(countDownLabel)

        let timeIcon = timeIcon
        view.addSubview(timeIcon)

        timeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        timeIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timeIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true

        countDownLabel.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 20).isActive = true
        countDownLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        countDownLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        countDownLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true

        let progressShapes = self.getProgressStrokes()
        view.layer.addSublayer(progressShapes.0)
        view.layer.addSublayer(progressShapes.1)

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        layoutViews()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CountDownCell {
    public func setupCell(countDown: CountDownEntity) { //TODO: Change to date
        countDownTitle.text = countDown.title
        self.eventDate = countDown.eventDate
        self.creationDate = countDown.creationDate
        countDownLabel.text = getDisplayedString(from: eventDate!)

        viewLoaded()
    }

    override internal func prepareForReuse() {
        super.prepareForReuse()
        countDownTitle.text = nil
        eventDate = nil
        creationDate = nil
        timer.invalidate()
    }
}

private extension CountDownCell {
    func viewLoaded() {
        countDownActivity.startAnimating()
        let toValue = getProgressDate(creationDate: creationDate!, eventDate: eventDate!)

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = toValue
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.duration = 1.0
        self.progressShape.add(animation, forKey: "progressStrokeAnimation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.countDownActivity.stopAnimating()
        }

        progressFromValue = toValue
        configureTimer()
    }

    func configure() {
        guard let creationDate, let eventDate else { return }
        progressFromValue = getProgressDate(creationDate: creationDate, eventDate: eventDate)
    }

    func addViews() {
        [countDownTitle, countDownView, countDownActivity].forEach { contentView.addSubview($0) }
    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            countDownTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            countDownTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            countDownTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            countDownTitle.heightAnchor.constraint(equalToConstant: 40),

            countDownActivity.centerYAnchor.constraint(equalTo: countDownView.centerYAnchor),
            countDownActivity.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            countDownActivity.widthAnchor.constraint(equalToConstant: 50),
            countDownActivity.heightAnchor.constraint(equalToConstant: 50),

            countDownView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            countDownView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            countDownView.topAnchor.constraint(equalTo: countDownTitle.bottomAnchor, constant: 10),
            countDownView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _  in
            let eventDate = self?.eventDate
            let creationDate = self?.creationDate

            guard let eventDate, let creationDate else { return }
            
            self?.countDownLabel.text = self?.getDisplayedString(from: eventDate)

            let progressValue = self?.getProgressDate(creationDate: creationDate, eventDate: eventDate)

            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = self?.progressFromValue
            animation.toValue = progressValue
            animation.isRemovedOnCompletion = false
            animation.fillMode = .forwards
            animation.duration = 1.0
            self?.progressShape.add(animation, forKey: "progressStrokeAnimation")

            self?.progressFromValue = progressValue ?? 0
        }
    }

    func getDisplayedString(from eventDate: Date) -> String {
        let duration = Int(Double(eventDate - Date.now).rounded())

        guard duration >= 0 else { return String(localized: "event_happend") }

        let seconds = duration % 60
        let minutes = (duration / 60) % 60
        let hours = duration / 3600
        let days = (duration / 3600) / 24

        let secondsStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let minutesStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let hoursStr = hours < 10 ? "0\(hours)" : "\(hours)"
        let daysStr = days < 10 ? "0\(days)" : "\(days)"

        return days == 0 ? [hoursStr, minutesStr, secondsStr].joined(separator: ":") : [daysStr, hoursStr, minutesStr, secondsStr].joined(separator: ":")
    }

    func getProgressDate(creationDate: Date, eventDate: Date) -> Double {
        let currentInterval = Date.now.timeIntervalSinceReferenceDate
        let startInterval = creationDate.timeIntervalSinceReferenceDate
        let endInterval = eventDate.timeIntervalSinceReferenceDate

        return ((currentInterval - startInterval) / (endInterval - startInterval))
    }

    func getProgressStrokes() -> (CAShapeLayer, CAShapeLayer) {
        let progressStroke = UIBezierPath()
        let rect = CGRect(x: 0,
                          y: 0,
                          width: self.contentView.bounds.width - 20,
                          height: self.contentView.bounds.height - 80)

        let cornerRadius = Double(20)


        progressStroke.move(to: CGPoint(x: rect.maxX / 2, y: 0))

        progressStroke.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: 0))
        progressStroke.addQuadCurve(to: CGPoint(x: rect.maxX,
                                                y: rect.minY + cornerRadius),
                                    controlPoint: CGPoint(x: rect.maxX,
                                                          y: rect.minY))

        progressStroke.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        progressStroke.addQuadCurve(to: CGPoint(x: rect.maxX - cornerRadius,
                                                y: rect.maxY),
                                    controlPoint: CGPoint(x: rect.maxX,
                                                          y: rect.maxY))

        progressStroke.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        progressStroke.addQuadCurve(to: CGPoint(x: rect.minX,
                                                y: rect.maxY - cornerRadius),
                                    controlPoint: CGPoint(x: rect.minX,
                                                          y: rect.maxY))

        progressStroke.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        progressStroke.addQuadCurve(to: CGPoint(x: rect.minX + cornerRadius,
                                                y: rect.minY),
                                    controlPoint: CGPoint(x: rect.minX,
                                                          y: rect.minY))

        progressStroke.addLine(to: CGPoint(x: rect.maxX / 2, y: 0))


        let trackShape = CAShapeLayer()
        trackShape.path = progressStroke.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 3
        trackShape.strokeColor = UIColor.white.cgColor
        trackShape.opacity = 0.1

        let progressShape = CAShapeLayer()
        progressShape.path = progressStroke.cgPath
        progressShape.fillColor = UIColor.clear.cgColor
        progressShape.lineWidth = 3
        progressShape.strokeColor = UIColor.white.cgColor
        progressShape.opacity = 1
        progressShape.lineCap = .round
        progressShape.strokeStart = 0
        progressShape.strokeEnd = 0
        self.progressShape = progressShape

        return (trackShape, progressShape)
    }
}
