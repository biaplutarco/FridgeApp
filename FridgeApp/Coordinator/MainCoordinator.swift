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
        navigationController.navigationBar.barTintColor = UIColor.AppColors.lightGray
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.AppColors.darkGray!]
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.AppColors.darkGray!]
        navigationController.navigationBar.shadowImage = UIImage()
    }
    
    func start() {
        let vc = FridgeViewController()
        vc.coordinator = self
        vc.title = "Sua Geladeira"
        navigationController.pushViewController(vc, animated: false)
    }
    
    func addProduct() {
        let vc = AddModalViewController()
        vc.coordinator = self
        navigationController.present(vc, animated: false, completion: nil)
    }
}
