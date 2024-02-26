import Foundation

protocol HomeInteractorProtocol: AnyObject {
   func loadCountDowns()
}

class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?

    func loadCountDowns() {
        CountDownEntity.getMockCountDowns { [weak self] countDowns in
            self?.presenter?.countDownsLoaded(countDowns: countDowns)
        }
    }
}
