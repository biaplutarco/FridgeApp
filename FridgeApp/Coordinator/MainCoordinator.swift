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
    let viewController = ViewController()
    let modalViewController = ModalViewController()
    
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
        viewController.coordinator = self
        viewController.title = "Sua Geladeira"
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToModelViewControllerWith(snapShot: UIImage) {
        modalViewController.delegate = self
        navigationController.present(modalViewController, animated: true) {
            self.modalViewController.setUpModelView(image: snapShot)
            self.modalViewController.configBackgroundImageView()
        }
    }
    
    func updateViewController() {
        print("colocar um alert aqui pra pessoa nao poder passar sem colocar imagem e cor")
        modalViewController.dismiss(animated: true) {
            self.viewController.insertCollectionItem()
        }
    }
}

extension MainCoordinator: NavigationDelegate {
    func didSaveProduct(_ product: Product) {
        viewController.insertProduct(product)
        updateViewController()
    }
}
