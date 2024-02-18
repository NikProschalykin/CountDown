import UIKit

final class HomeNavigationView: UIView {
    private let dateFormatterService = DateFormatterService()
    private var timer = Timer()
    private var fromValue = 0.0

    private lazy var dateStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .equalCentering

        $0.addArrangedSubview(dayLabel)
        $0.addArrangedSubview(monthLabel)

        return $0
    }(UIStackView(frame: .zero))

    private lazy var dayLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 34)
        $0.textColor = Resources.Colors.Strings.text
        $0.textAlignment = .center

        return $0
    }(UILabel())

    private lazy var monthLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 34)
        $0.textColor = Resources.Colors.Strings.text

        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        layoutViews()
        configure()
        configureTimer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeNavigationView {
}

private extension HomeNavigationView {
    func addViews() {
        addSubview(dateStackView)
    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            dateStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateStackView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            dateStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }

    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Resources.Colors.Backgrounds.background
        drawDayProgress()
        monthLabel.text = dateFormatterService.getCurrentMonthFullString()
        dayLabel.text = dateFormatterService.getCurrentDayString()
    }

    func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            self.drawDayProgress()
            self.monthLabel.text = self.dateFormatterService.getCurrentMonthFullString()
            self.dayLabel.text = self.dateFormatterService.getCurrentDayString()
        })
    }

    func drawDayProgress() {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents(in: calendar.timeZone, from: calendar.startOfDay(for: Date()))
        let startDay = calendar.date(from: components)
        components.day! += 1
        let endDay = calendar.date(from: components)

        let percent = self.dateFormatterService.getProgressValue(creationDate: startDay!, eventDate: endDay!)
        self.drawProgressLayer(percent: percent)
    }

    func drawProgressLayer(percent: Double) {
        dateStackView.layer.sublayers?.removeAll(where: {
            $0 != dayLabel.layer && $0 != monthLabel.layer
        })

        let strokePath = UIBezierPath(arcCenter: CGPoint(x: 70, y: 80),
                                      radius: 90,
                                      startAngle: .pi,
                                      endAngle: 2 * .pi,
                                      clockwise: true)

        let trackShape = CAShapeLayer()
        trackShape.path = strokePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 3
        trackShape.strokeColor = UIColor.white.cgColor
        trackShape.opacity = 1
        trackShape.strokeEnd = percent

        let defaultTrackShape = CAShapeLayer()
        defaultTrackShape.path = strokePath.cgPath
        defaultTrackShape.fillColor = UIColor.clear.cgColor
        defaultTrackShape.lineWidth = 3
        defaultTrackShape.strokeColor = UIColor.white.cgColor
        defaultTrackShape.opacity = 0.3
        defaultTrackShape.strokeEnd = 1

        let dotAngle = CGFloat.pi * (1 - percent)
        let dotPoint = CGPoint(x: cos(-dotAngle) * 90 + 70,
                               y: sin(-dotAngle) * 90 + 80)

        let dotPath = UIBezierPath()
        dotPath.move(to: dotPoint)
        dotPath.addLine(to: dotPoint)

        let backGroundDotShape = CAShapeLayer()
        backGroundDotShape.path = dotPath.cgPath
        backGroundDotShape.lineWidth = 10
        backGroundDotShape.lineCap = .round
        backGroundDotShape.strokeColor = UIColor.white.cgColor
        backGroundDotShape.fillColor = UIColor.clear.cgColor

        let dotShape = CAShapeLayer()
        dotShape.path = dotPath.cgPath
        dotShape.lineWidth = 5
        dotShape.lineCap = .round
        dotShape.strokeColor = UIColor.red.cgColor
        dotShape.fillColor = UIColor.clear.cgColor

        let barsRadius: CGFloat = 105

        let barsPath = UIBezierPath(arcCenter: CGPoint(x: 70, y: 80),
                                    radius: barsRadius,
                                    startAngle: .pi,
                                    endAngle: .pi * 2,
                                    clockwise: true)

        let barsShape = CAShapeLayer()
        barsShape.path = barsPath.cgPath
        barsShape.fillColor = UIColor.clear.cgColor
        barsShape.strokeColor = UIColor.clear.cgColor
        barsShape.lineWidth = 6

        let startBarRadius = barsRadius - barsShape.lineWidth * 0.5
        let endBarRadius = startBarRadius + 10

        var angle: CGFloat = 1

        (1...6).forEach { _ in
            let barAngle = CGFloat.pi * angle
            let startBarPoint = CGPoint(x: cos(-barAngle) * startBarRadius + CGFloat(70),
                                        y: sin(-barAngle) * startBarRadius + CGFloat(80))

            let endBarPoint = CGPoint(x: cos(-barAngle) * endBarRadius + CGFloat(70),
                                        y: sin(-barAngle) * endBarRadius + CGFloat(80))

            let barPath = UIBezierPath()
            barPath.move(to: startBarPoint)
            barPath.addLine(to: endBarPoint)

            let barShape = CAShapeLayer()
            barShape.path = barPath.cgPath
            barShape.fillColor = UIColor.clear.cgColor
            barShape.strokeColor = dateFormatterService.currentTimeOfDay() == .day ? UIColor.white.cgColor : UIColor.clear.cgColor
            barShape.lineCap = .round
            barShape.lineWidth = 4

            barsShape.addSublayer(barShape)

            angle -= 1 / 5
        }

        dateStackView.layer.addSublayer(defaultTrackShape)
        dateStackView.layer.addSublayer(trackShape)
        dateStackView.layer.addSublayer(backGroundDotShape)
        dateStackView.layer.addSublayer(dotShape)
        dateStackView.layer.addSublayer(barsShape)
    }
}
