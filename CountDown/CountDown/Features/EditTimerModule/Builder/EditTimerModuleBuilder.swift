import UIKit

enum EditTimerViewType {
    case edit
    case add
}

class EditTimerModuleBuilder {
    static func build(viewType: EditTimerViewType, timerItem: CountDownEntity? = nil) -> EditTimerViewController {
        let interactor = EditTimerInteractor()
        let router = EditTimerRouter()
        let presenter = EditTimerPresenter(interactor: interactor, router: router)
        let viewController = EditTimerViewController()
        viewController.viewType = viewType
        viewController.timerItem = timerItem
        
        presenter.view = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
