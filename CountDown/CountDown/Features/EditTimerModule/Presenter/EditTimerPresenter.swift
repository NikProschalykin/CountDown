protocol EditTimerPresenterProtocol: AnyObject {
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
}
