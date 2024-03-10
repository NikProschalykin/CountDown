//
//  WorldPresenter.swift
//
//  Created by Николай Прощалыкин on 09.03.2024
//

protocol WorldPresenterProtocol: AnyObject {
}

class WorldPresenter {
    weak var view: WorldViewProtocol?
    var router: WorldRouterProtocol
    var interactor: WorldInteractorProtocol

    init(interactor: WorldInteractorProtocol, router: WorldRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension WorldPresenter: WorldPresenterProtocol {
}
