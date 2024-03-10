import Foundation

protocol EditTimerInteractorProtocol: AnyObject {
   func editCountDown(title: String?, date: Date?)
}

class EditTimerInteractor: EditTimerInteractorProtocol {
    weak var presenter: EditTimerPresenterProtocol?

    func editCountDown(title: String?, date: Date?) {
        // TODO: Save to CoreData if failure then presenter.showBadRequestCDAlert
    }
}
