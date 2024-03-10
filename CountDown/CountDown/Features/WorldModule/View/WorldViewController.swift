//
//  WorldViewController.swift
//
//  Created by Николай Прощалыкин on 09.03.2024
//

import UIKit

protocol WorldViewProtocol: AnyObject {
}

class WorldViewController: UIViewController {
    // MARK: - Public
    var presenter: WorldPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
    }
}

// MARK: - Private functions
private extension WorldViewController {
    func configure() {
    }
    
    func addViews() {
    }
    
    func layoutViews() {
    }
}

// MARK: - @objc extension
@objc extension WorldViewController {
    
}

// MARK: - WorldViewProtocol
extension WorldViewController: WorldViewProtocol {
}
