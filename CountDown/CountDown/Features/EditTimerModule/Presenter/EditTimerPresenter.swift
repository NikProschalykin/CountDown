import Foundation

protocol EditTimerPresenterProtocol: AnyObject {
    func editCountDown(title: String?, date: Date?)
    func editCountDownBadSaveCD()
}

class EditTimerPresenter {
    weak var view: EditTimerViewProtocol?
    var router: EditTimerRouterProtocol
    var interactor: EditTimerInteractorProtocol

    init(interactor: EditTimerInteractorProtocol, router: EditTimerRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension EditTimerPresenter: EditTimerPresenterProtocol {
    func editCountDownBadSaveCD() {
        view?.showBadRequestCDAlert()
    }

    func editCountDown(title: String?, date: Date?) {
        interactor.editCountDown(title: title, date: date)
    }
}
