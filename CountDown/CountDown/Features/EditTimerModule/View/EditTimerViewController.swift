import UIKit

protocol EditTimerViewProtocol: AnyObject {
    func showBadRequestCDAlert()
}

class EditTimerViewController: UIViewController {
    // MARK: - Public
    var presenter: EditTimerPresenterProtocol?
    var viewType: EditTimerViewType?
    var eventDate = Date()
    var timerTitle = ""
    var timerItem: CountDownEntity?

    // MARK: - Private
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        $0.textColor = Resources.Colors.Strings.text
        $0.text = viewType == .add
            ? String(localized: "addTimerTitle")
            : String(localized: "editTimerTitle")

        return $0
    }(UILabel())

    private let editTimerView = EditTimerView()

    private lazy var addTimerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let title = viewType == .add ?
        String(localized: "add_timer_button") :
        String(localized: "save_timer_button")

        let attributs = AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])

        config.attributedTitle = AttributedString(title, attributes: attributs)

        $0.configuration = config

        $0.makeSystem($0)

        $0.layer.cornerRadius = 8
        $0.backgroundColor = .systemGreen

        $0.addTarget(self, action: #selector(addTimerButtonTapped), for: .touchUpInside)

        return $0
    }(UIButton(frame: .zero))

    private lazy var viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
        setupTimerData()
    }
}

// MARK: - Private functions
private extension EditTimerViewController {
    func configure() {
        view.backgroundColor = Resources.Colors.Backgrounds.background
        editTimerView.vcDelegate = self
        view.addGestureRecognizer(viewTapGesture)
    }

    func addViews() {
        [titleLabel, editTimerView, addTimerButton].forEach { view.addSubview($0) }
    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),

            editTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            editTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            editTimerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            editTimerView.heightAnchor.constraint(equalToConstant: 120),

            addTimerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTimerButton.topAnchor.constraint(equalTo: editTimerView.bottomAnchor, constant: 30)
        ])
    }
    
    func setupTimerData() {
        guard let timerItem else { return }
        self.eventDate = timerItem.eventDate
        self.timerTitle = timerItem.title
        editTimerView.datePicker.date = self.eventDate
        editTimerView.titleTextField.text = self.timerTitle
    }
}

// MARK: - objc extensions
@objc private extension EditTimerViewController {
     func hideKeyboard() {
        view.endEditing(true)
    }

    func addTimerButtonTapped() {
        print("add timer button tapped")
    }

    func viewDidTapped() {
        hideKeyboard()
    }
}

// MARK: - EditTimerViewProtocol
extension EditTimerViewController: EditTimerViewProtocol {
    func showBadRequestCDAlert() {
    }
}

// MARK: - EditTimerViewDelegate
extension EditTimerViewController: EditTimerViewDelegate {
}
