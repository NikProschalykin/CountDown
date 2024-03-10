import UIKit

protocol EditTimerViewDelegate: AnyObject {
    var eventDate: Date { get set }
}

final class EditTimerView: UIView {
    weak var vcDelegate: EditTimerViewDelegate?

    lazy var titleTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = String(localized: "enter_title")
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.returnKeyType = .done
        $0.delegate = self

        return $0
    }(UITextField(frame: .zero))

    private lazy var textFieldStack: UIStackView = {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)
        let image = Resources.Icons.titleIcon?.withConfiguration(imageConfig)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
        $0.addArrangedSubview(imageView)
        $0.addArrangedSubview(titleTextField)

        return $0
    }(UIStackView(frame: .zero))

     lazy var datePicker: UIDatePicker = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.datePickerMode = .dateAndTime
        $0.timeZone = NSTimeZone.local
        $0.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        
        return $0
    }(UIDatePicker(frame: .zero))

    private lazy var separatorView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray
        $0.layer.cornerRadius = 2
        $0.layer.masksToBounds = true

        return $0
    }(UIView(frame: .zero))

    private lazy var dateLable: UIStackView = {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)
        let image = Resources.Icons.calendarIcon?.withConfiguration(imageConfig)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized: "date_label")
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 10
        $0.addArrangedSubview(imageView)
        $0.addArrangedSubview(label)

        return $0
    }(UIStackView(frame: .zero))


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

private extension EditTimerView {
    func addViews() {
        [textFieldStack, separatorView, datePicker, dateLable].forEach { addSubview($0) } //
    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            textFieldStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textFieldStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textFieldStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),

            separatorView.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 20),
            separatorView.leadingAnchor.constraint(equalTo: textFieldStack.leadingAnchor, constant: 20),
            separatorView.trailingAnchor.constraint(equalTo: textFieldStack.trailingAnchor, constant: -20),
            separatorView.heightAnchor.constraint(equalToConstant: 2),

            dateLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLable.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),

            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            datePicker.centerYAnchor.constraint(equalTo: dateLable.centerYAnchor)
        ])
    }

    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Resources.Colors.Backgrounds.countDownViewBackground
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}

// MARK: - @objc extension
@objc extension EditTimerView {
    func datePickerChanged(_ sender: UIDatePicker) {
        vcDelegate?.eventDate = sender.date
    }
}

// MARK: - UITextFieldDelegate
extension EditTimerView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}
