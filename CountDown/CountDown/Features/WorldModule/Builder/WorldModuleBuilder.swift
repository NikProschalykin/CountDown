//
//  WorldModuleBuilder.swift
//
//  Created by Николай Прощалыкин on 09.03.2024
//

import UIKit

class WorldModuleBuilder {
    static func build() -> WorldViewController {
        let interactor = WorldInteractor()
        let router = WorldRouter()
        let presenter = WorldPresenter(interactor: interactor, router: router)
        let viewController =  WorldViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
