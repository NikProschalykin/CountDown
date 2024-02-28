import UIKit

protocol EditTimerViewProtocol: AnyObject {
}

class EditTimerViewController: UIViewController {
    // MARK: - Public
    var presenter: EditTimerPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
    }
}

// MARK: - Private functions
private extension EditTimerViewController {
    func configure() {
    }
    
    func addViews() {
    }
    
    func layoutViews() {
    }
}

// MARK: - @objc extension
@objc extension EditTimerViewController {
    
}

// MARK: - EditTimerViewProtocol
extension EditTimerViewController: EditTimerViewProtocol {
}
