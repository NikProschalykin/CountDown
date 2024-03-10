//
//  WorldInteractor.swift
//
//  Created by Николай Прощалыкин on 09.03.2024
//

protocol WorldInteractorProtocol: AnyObject {
}

class WorldInteractor: WorldInteractorProtocol {
    weak var presenter: WorldPresenterProtocol?
}
