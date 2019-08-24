//
//  AppCoordinator.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        configNavController()
    }
    
    private func configNavController() {
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let vc = FridgeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
