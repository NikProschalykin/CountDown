protocol EditTimerInteractorProtocol: AnyObject {
}

class EditTimerInteractor: EditTimerInteractorProtocol {
    weak var presenter: EditTimerPresenterProtocol?
}
