import UIKit

class EditTimerModuleBuilder {
    static func build() -> EditTimerViewController {
        let interactor = EditTimerInteractor()
        let router = EditTimerRouter()
        let presenter = EditTimerPresenter(interactor: interactor, router: router)
        let viewController =  EditTimerViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
