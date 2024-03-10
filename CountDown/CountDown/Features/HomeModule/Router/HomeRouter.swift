protocol HomeRouterProtocol {
    func presentEditTimer(viewType: EditTimerViewType, timerItem: CountDownEntity?)
}

class HomeRouter: HomeRouterProtocol {
    weak var viewController: HomeViewController?

    func presentEditTimer(viewType: EditTimerViewType, timerItem: CountDownEntity? = nil) {
        
        let editTimerVC = viewType == .add
        ? EditTimerModuleBuilder.build(viewType: viewType)
        : EditTimerModuleBuilder.build(viewType: viewType, timerItem: timerItem)
        
        viewController?.present(editTimerVC, animated: true)
    }
}
