protocol HomePresenterProtocol: AnyObject {
    func viewLoaded()
    func countDownsLoaded(countDowns: [CountDownEntity])
}

class HomePresenter {
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol
    var interactor: HomeInteractorProtocol

    init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewLoaded() {
        interactor.loadCountDowns()
    }

    func countDownsLoaded(countDowns: [CountDownEntity]) {
        view?.showCountDowns(countDowns: countDowns)
    }
}
