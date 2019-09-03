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
    let viewController = ProductsViewController()
    let modalViewController = ModalViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.configNavigationBar()
    }
    
    func start() {
        viewController.delegate = self
        viewController.title = "Sua Geladeira"
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension MainCoordinator: ProductsViewControllerDelegate {
    func presentModalWith(backgroundImage: UIImage) {
        navigationController.present(modalViewController, animated: true) {
            self.modalViewController.delegate = self
            self.modalViewController.setUpModelView(image: backgroundImage)
            self.modalViewController.configBackgroundImageView()
        }
    }
}

extension MainCoordinator: NavigationDelegate {
    func didSaveProduct(_ product: Product) {
        viewController.insertProduct(product)
//        colocar um alert aqui pra pessoa nao poder passar sem colocar imagem e cor
        modalViewController.dismiss(animated: true) {
            self.viewController.insertCollectionItem()
        }
    }
}
